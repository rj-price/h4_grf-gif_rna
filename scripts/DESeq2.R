# Install and load DESeq2
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("DESeq2")
library(DESeq2)

# Import count data
count_data <- read.table("grf-gif_featurecounts.txt", header = TRUE, row.names = 1)

# Define sample metadata
sample_metadata <- data.frame(
    row.names = colnames(count_data),
    condition = c("wheat", "wheat", "wheat", "vitis", "vitis", "vitis", "vitis_miR", "vitis_miR", "vitis_miR", "citris", "citris", "citris", "control", "control", "control")
)

# Create DESeq2 dataset
dds <- DESeqDataSetFromMatrix(countData = count_data,
                              colData = sample_metadata,
                              design = ~ condition)

# Set control as reference level
dds$condition <- relevel(dds$condition, ref = "control")

# Perform VST normalisation and plot PCA
vsd <- vst(dds, blind = FALSE)
plotPCA(vsd, intgroup = "condition")

# Run DESeq2 analysis
dds <- DESeq(dds)

# Iterate through list of conditions to compare to control, and export tables as csv files.
cond_list <- c("wheat", "vitis", "vitis_miR", "citris")

for (cond in cond_list) {
  contrast_str <- c("condition", cond, "control")
  cond_res <- results(dds, contrast = contrast_str)
  output_file <- paste0(cond, "_results.csv")
  write.csv(as.data.frame(cond_res), file = output_file)
}
