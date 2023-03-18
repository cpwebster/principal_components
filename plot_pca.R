library(tidyverse)



# ---------------------
# Data prep and parsing
# ---------------------

#read in files with principal components
pca <- read_table("<plink_prunned_output_file.eigenvec>", col_names = FALSE)
eigenval <- scan("<plink_prunned_output_file.eigenval>")

#read in population data
pop.data <- read.table("<your_population_metadata.txt>", sep = "\t", header = TRUE)

#remove nuisance column
pca <- pca[,-1]

#set column names to pca file
names(pca)[1] <- "ind"
names(pca)[2:ncol(pca)] <- paste0("PC", 1:(ncol(pca)-1))

#group by population
#alter for number of populations
Group <- rep(NA, length(pop.data))
Group[grep("1", pop.data$Pop)] <- "1"
Group[grep("2", pop.data$Pop)] <- "2"
Group[grep("3", pop.data$Pop)] <- "3"
Group[grep("4", pop.data$Pop)] <- "4"

#group by species
#alter for number of species
Species <- rep(NA, length(pop.data))
Species[grep("species_1", pop.data$SP)] <- "Species 1"
Species[grep("species_2", pop.data$SP)] <- "Species 2"

#make new data frame (with sample names, group, and species)
pca_1 <- tibble(pca, Group, Species)



# --------------------------
# Percent variance explained
# --------------------------

#convert to percentage variance explained
pve <- data.frame(PC = 1:20, pve = eigenval/sum(eigenval)*100)

#make plot % variance explained
perc_var <-
  ggplot(pve, aes(PC, pve)) + geom_bar(stat = "identity") +
  ylab("Percentage variance explained") +
  theme_light()
perc_var

#calculate the cumulative sum of the percentage variance explained
cumsum(pve$pve)



# --------
# PCA plot
# --------

# The following code creates a PCA plot with points that are colored by
# population (group) and shaped by species. Omit geompoint() line if
# you only want to color by population. You will need to add colors to
# scale_colour_manual() line if looking at >2 populations.

# This default is comparing PC1 with PC2, if needing to compare other
# PCs (see percent variation), change values on ggplot() and
# xlab() and ylab() lines.

pca_plot <-
  ggplot(pca_1, aes(x=PC1, y=PC2, col = Group)) +
  geom_point(aes(shape = Species), size=3.5, alpha=0.6) +
  scale_colour_manual(values = c("deeppink1","darkorchid")) +
  geom_hline(yintercept = 0) +
  geom_vline(xintercept = 0) +
  theme_bw() +
  ggtitle("<plot_title_here") + 
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab(paste0("PC1 (", signif(pve$pve[1], 3), "%)")) + 
  ylab(paste0("PC2 (", signif(pve$pve[2], 3), "%)"))
pca_plot

#save plot
ggsave(
  "PC1_PC2.png",
  device = NULL,
  scale = 1,
  width = 9,
  height = 5,
  units = c("in"),
  dpi = 300)




















