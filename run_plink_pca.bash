# The following script will utilize an input VCF (cannot be compressed) and call VCFtools 
# (Danecek et al., 2011) to create a new VCF with no indels. Then, Plink 1.9 beta will 
# perform linkage pruning and calculate principal components. The resulting .eigenvec and 
# .eigenval files are intended to be used with plot_pca.R to visualize the statistics.

# [-------------]
#     USAGE:
# [-------------]

# bash run_plink_pca.bash -v <input_vcf_file> -o <output_file_prefix>

# ------------
# Arguments
# ------------

while getopts ":v:o:" opt; do
  case ${opt} in

# Input VCF file
    v ) input_vcf_file="$OPTARG"
      ;;
# Output file prefix                                                                
    o ) output_prefix="$OPTARG"                                                
      ;; 

    \? ) echo "Invalid option: -$OPTARG" 1>&2
      ;;
    : ) echo "Option -$OPTARG requires an argument." 1>&2
      ;;

  esac
done

# Load needed modules

module purge
module load vcftools/0.1.12b
module load plink/1.9.0


# ----------------------------------
# Creating new VCF with no indels
# ----------------------------------

vcftools --vcf ${input_vcf_file} \
--remove-indels \
--recode \
--recode-INFO-all \
--out vcf_no_indels

echo "[ *** New VCF with no indels created *** ]"

# ------------------
# Linkage prunning
# ------------------

#perform linkage pruning (identify sites to be pruned)
#threads argument: more efficient processing
#indep-pairwise argument: <window size> <step size> <r^2 threshold>

plink --vcf vcf_no_indels.recode.vcf \
--allow-extra-chr 0 \
--double-id \
--threads 8 \
--indep-pairwise 50 10 0.1 \
--out to_be_prunned

echo "[ *** Identified sites to be prunned *** ]"

# --------------------------------
# Calculate principal components
# --------------------------------

#calculate PCA with pruned linkage data

plink --vcf vcf_no_indels.recode.vcf \
--double-id \
--allow-extra-chr \
--extract to_be_prunned.prune.in \
--make-bed \
--threads 8 \
--pca \
--out ${output_prefix}

echo "[ *** Calculated principal components with prunned linkage data! *** ]"

# -------------------
# Clean environment
# -------------------

rm vcf_no_indels.*
rm to_be_prunned.*









