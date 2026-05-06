setwd("~/ML_projects/carp_cooccurence")  # set working directory

library(cooccur)  # load co-occurrence analysis package
library(pheatmap)  # load heatmap visualization package

data(finches)  # load example species-site presence-absence data
print(finches)  # inspect raw matrix

pheatmap(as.matrix(finches),
         cluster_rows = TRUE,   # cluster species
         cluster_cols = TRUE,   # cluster sites
         color = c("white", "black"))  # presence/absence colors

result <- cooccur(mat = finches,
                  type = "spp_site",  # species in rows, sites in cols
                  thresh = TRUE,      # filter rare species pairs
                  spp_names = TRUE)   # use species names

print(summary(result))  # summarize overall co-occurrence results

plot(result)  # plot summary diagnostics

print(prob.table(result)[1:10, ])  # first 10 pairwise probabilities

print(pair(mod = result, "Geospiza fortis"))  # pairwise stats for focal species

print(pair.attributes(result))  # model attributes and settings

print(pair.profile(result))  # species interaction profile summary

print(obs.v.exp(result))  # observed vs expected co-occurrence comparison

print(round(effect.sizes(result,matrix=TRUE),3))
