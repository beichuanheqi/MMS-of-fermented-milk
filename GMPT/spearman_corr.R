library(readxl)
library(dplyr)
file_path <- "Correlation.xlsx"
sheet_names <- excel_sheets(file_path)
exclude_attrs <- c("fermented", "sour", "milky", "creamy", 
                   "buttery", "cheesy", "fruity", "sweety")
all_results <- list()
for (sheet in sheet_names) {

  df <- read_excel(file_path, sheet = sheet)
  df <- as.data.frame(df)
  var_names <- as.character(df[, 1])
  num_data <- df[, -1]
  score_vec <- as.numeric(num_data[nrow(num_data), ])
  score_name <- var_names[nrow(num_data)]
  asv_indices <- which(!(tolower(var_names) %in% exclude_attrs) & 
                         (1:length(var_names) != nrow(num_data)))
  res_df <- data.frame(
    Phenotype = sheet,
    Taxa = var_names[asv_indices],
    Rho = numeric(length(asv_indices))
  )
  for (i in seq_along(asv_indices)) {
    row_idx <- asv_indices[i]
    asv_vec <- as.numeric(num_data[row_idx, ])
    test <- cor.test(asv_vec, score_vec, method = "spearman", exact = FALSE)
    res_df$Rho[i] <- test$estimate
  }
  
  all_results[[sheet]] <- res_df
}

final_cor_results <- bind_rows(all_results)
print(head(final_cor_results))
write.csv(final_cor_results, "GMPT_Final_Causal_Microbes2.csv", row.names = FALSE)