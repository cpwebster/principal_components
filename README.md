# principal_components
Included are a text document of commands that call VCFtools (Danecek et al., 2011) and Plink 1.9 beta to calculate principal components for a given VCF, an example of the metadata file needed, and the R script that uses the principal component results and metadata to create a plot.

#plink_pca_commands.txt:

This text file contains a series of commands that call VCFtools and Plink 1.9 beta to remove indels, perform linkage prunning, and calculate principal components for a given VCF.

#population_meta_data_example.txt:

This text file is an example of a metadata file that is needed for plot_pca.R to be executed. This is a tab-delimited text file with a header, sample name in the first column, cooresponding population in the second column, and cooresponding species (name or abbreviation) in third column.

#plot_PCA.R

This R script reads in output files from principal component analyses and metadata documents to produce principal component plots. It's suggested to run this script line by line to tailor for given needs.
