# principal_components
The following scripts and file utilize VCFtools (Danecek et al., 2011) and Plink 1.9 beta to calculate principal components for a given VCF, provide an example of the metadata file needed to plot the principal components, and the R script that visualizes the principal components and metadata.

Intended workflow: (run in the same directory)
1) run_plink_pca.bash
2) plot_pca.R

#run_plink_pca.bash

This script will call VCFtools and Plink 1.9 beta to create a VCF file with no indels, performs linkage pruning, and creates .eigenvec and .eigenval files that will be used to visualize the principal components. This script cannot be run on a compressed VCF.

USAGE: bash run_plink_pca.bash -v <input_vcf_file> -o <output_file_prefix>

#population_meta_data_example.txt:

This text file is an example of a metadata file that is needed for plot_pca.R to be executed. This is a tab-delimited text file with a header, sample name in the first column, cooresponding population in the second column, and cooresponding species (name or abbreviation) in third column.

#plot_PCA.R:

This R script reads in output files from principal component analyses (.eigenvec and .eigenval) and the metadata text file to produce principal component plots. The default is written for PCs with 5 populations and 2 species; script should be run line by line to tailor for individual needs.
