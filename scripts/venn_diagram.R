# Taken from the following website
# https://www.datanovia.com/en/blog/venn-diagram-with-r-or-rstudio-a-million-ways/

# Install packages
if (!require(devtools)) install.packages("devtools")
devtools::install_github("yanlinlin82/ggvenn")

# Load library
library(ggvenn)

# Import sigDEG gene names
citris <- readLines("GRF-GIF_Citris_vs_Control_SigDEGs_names.txt")
vitis <- readLines("GRF-GIF_Vitis_vs_Control_SigDEGs_names.txt")
vitis_miR <- readLines("GRF-GIF_Vitis_miR_vs_Control_SigDEGs_names.txt")
wheat <- readLines("GRF-GIF_Wheat_vs_Control_SigDEGs_names.txt")

venndata <- list(
  "Cc GRF-GIF" = citris, 
  "Vv GRF-GIF" = vitis, 
  "Vv miR GRF-GIF" = vitis_miR,
  "Ta GRF-GIF" = wheat)
  
# Plot 4-way venn diagram
ggvenn(
  venndata, 
  fill_color = c("#0073C2FF", "#EFC000FF", "#868686FF", "#CD534CFF"),
  stroke_size = 0.5, set_name_size = 5, show_percentage = FALSE
)

# Output names of shared genes
library(gplots)
v.table <- venn(venndata)
print(v.table)
