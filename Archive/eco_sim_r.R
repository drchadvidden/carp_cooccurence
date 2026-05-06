setwd("~/ML_projects/carp_cooccurence")

library(EcoSimR)
library(cooccur)
data(finches)

############################
# data load
############################
df <- dataWiFinches[, -1]                        # remove Species column
rownames(df) <- dataWiFinches$Species    # set species as rownames
df <- finches

#df <- read.csv("pres_abs.csv", header=TRUE)
#ind <- which(df[1,2:ncol(df)] > 2007)+1 # after breakpoint
#ind <- which(df[1,2:ncol(df)] <= 2007)+1 # before breakpoint
#df <- df[,c(1,ind)]
#colnames(df) <- paste(colnames(df), df[1, ], sep = "_")
#df <- df[3:nrow(df), ]
#rownames(df) <- df[,1]  
#df <- df[, -1]

print(df[1:5, 1:5])
  
############################
# summary stats
############################
cat("Species:", nrow(df), "\n")
cat("Sites:", ncol(df), "\n")
cat("Total presences:", sum(df), "\n")
cat("Fill percent:", round(sum(df)/(nrow(df)*ncol(df)),2), "\n")
sort(round(rowSums(df)/ncol(df),3), decreasing=TRUE)    # occurrences per species
sort(round(colSums(df)/nrow(df),3), decreasing=TRUE)    # richness per site
c_score(as.matrix(df))

############################
# cooccurence null model
############################
df_cooc <- cbind(ID = rownames(df), df)
rownames(df_cooc) <- NULL
nullMod <- cooc_null_model(df_cooc, algo = "sim9", nReps = 10000)
summary(nullMod)
#plot(nullMod, type = "cooc")
plot(nullMod, type = "hist")


