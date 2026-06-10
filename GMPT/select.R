base_folder <- "C:/Users/19220/Desktop/GMPT"

folders <- c("FER", "MIL", "FRU", "CHE")

for (folder_name in folders) {
  folder <- file.path(base_folder, folder_name)
  
  files <- list.files(
    path = folder,
    pattern = "^res_.*\\.csv$",
    full.names = TRUE
  )
  
  rowname_count <- c()
  
  for (file in files) {
    dat <- read.csv(file, row.names = 1, check.names = FALSE)
    effect_values <- as.numeric(dat[["effect"]])
    
    selected_rownames <- rownames(dat)[
      !is.na(effect_values) & abs(effect_values) > 0.5
    ]
    
    for (rn in selected_rownames) {
      if (rn %in% names(rowname_count)) {
        rowname_count[rn] <- rowname_count[rn] + 1
      } else {
        rowname_count[rn] <- 1
      }
    }
  }
  
  result <- data.frame(
    rowname = names(rowname_count),
    count = as.integer(rowname_count),
    row.names = NULL
  )
  
  write.csv(
    result,
    file = file.path(folder, paste0(folder_name, "_effect_abs_gt_0.5_count.csv")),
    row.names = FALSE
  )
  
  cat("Finish:", folder_name, "\n")
}
