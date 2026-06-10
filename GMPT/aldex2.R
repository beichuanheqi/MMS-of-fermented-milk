library(ALDEx2)
library(dplyr)

asv_table <- read.csv("asv_table.csv", row.names = 1, check.names = FALSE)
metadata <- read.csv("metadata.csv", row.names = 1, check.names = FALSE)

group_list <- list(
  FER = c("FER_Group2", "FER_Group3", "FER_Group4", "FER_Target"),
  MIL = c("MIL_Group2", "MIL_Group3", "MIL_Group4", "MIL_Group5", "MIL_Target"),
  CHE = c("CHE_Group2", "CHE_Group3", "CHE_Group4", "CHE_Target"),
  FRU = c("FRU_Group2", "FRU_Group3", "FRU_Group4", "FRU_Target")
)

for (category in names(group_list)) {
  
  ordered_groups <- group_list[[category]]
  col_name <- paste0("Group_", category) 
  
  all_pairs <- combn(ordered_groups, 2)
  
  for (i in 1:ncol(all_pairs)){
    grad_base <- all_pairs[1, i]
    grad_target <- all_pairs[2, i]
    sub_meta <- metadata[metadata[[col_name]] %in% c(grad_target, grad_base), ]
    sub_meta <- sub_meta[order(sub_meta[[col_name]] == grad_target), ]
    sub_asv <- asv_table[, rownames(sub_meta), drop = FALSE]
    sub_asv <- sub_asv[rowSums(sub_asv) > 0, , drop = FALSE]
    n_base <- sum(sub_meta[[col_name]] == grad_base)
    n_target <- sum(sub_meta[[col_name]] == grad_target)
    conds <- c(rep("Base", n_base), rep("Target", n_target))

    x <- aldex.clr(sub_asv, conds, mc.samples=200, denom="all", verbose=FALSE)
    t_test <- aldex.ttest(x, paired.test=FALSE)
    eff <- aldex.effect(x, CI=TRUE, verbose=FALSE)
    res <- data.frame(t_test, eff)
    file_name <- paste0("res_", grad_target, "_vs_", grad_base, ".csv")
    write.csv(res, file=file_name, row.names=TRUE)
    cat("successfully save:", file_name, "\n\n")
  }
}