#setwd("Desktop/PhD/Cophylo/")
#setwd("treeduckentryouts/Cophylo_Paper/")

#args[n]

main <- function(){
  args <- commandArgs(trailingOnly = TRUE)



  ## write.jane function


write.jane <- function(cophyObject, file)
{
  
  cat(paste("#NEXUS ","\n", sep = ""),
      file = file, append = TRUE)
  
  
  H_tree_file <- ape::unroot(cophyObject$host_tree)
  S_tree_file <- ape::unroot(cophyObject$symb_tree)
  
  H_tree <- ape::write.tree(H_tree_file)
  S_tree <- ape::write.tree(S_tree_file)
  
  
  cat(paste("BEGIN HOST",";\n", sep = ""),
      file = file, append = TRUE)
  cat(paste("\ttree * HOST = ",H_tree,"\n", sep = ""),
      file = file, append = TRUE)
  
  cat(paste("ENDBLOCK",";\n", sep = ""),
      file = file, append = TRUE)
  
  
  cat(paste("\n", "BEGIN PARASITE",";\n", sep = ""),
      file = file, append = TRUE)
  cat(paste("\ttree * PARA = ",S_tree,"\n", sep = ""),
      file = file, append = TRUE)
  
  cat(paste("ENDBLOCK",";\n", sep = ""),
      file = file, append = TRUE)
  
  aso_mat <- cophyObject$association_mat
  
  cat(paste("\n", "BEGIN DISTRIBUTION",";\n", sep = ""),
      file = file, append = TRUE)
  cat(paste("\tRANGE ","\n", sep = ""),
      file = file, append = TRUE)
  
  
  for (i in 1:length(rownames(aso_mat))){
    temp <- aso_mat[i,]
    for ( j in 1:length(temp)){
      if ( temp[j] == 1) {
        H <- rownames(aso_mat)[i]
        S <- colnames(aso_mat)[j]
        cat(paste("\t", "\t", S, ":", H,  ",\n", sep = ""),
            file = file, append = TRUE)
      }
    }
  }
  
  
  cat(paste("\t",";\n", sep = ""),
      file = file, append = TRUE)
  cat(paste("END",";\n", sep = ""),
      file = file, append = TRUE)
  
  
} 

dir_num <- args[4]  

new_dir <- paste0("Simulation_",dir_num,"_NoExtinction")
dir.create(new_dir)
dir.create(paste0(new_dir,"/trees"))
dir.create(paste0(new_dir,"/data"))

#library(devtools)
#install_github("wadedismukes/treeducken")
#library(treeducken)


numb_replicates <- as.numeric(args[5])

### Constant Parameters
host_mu <-  0  
symb_mu <- 0  
time <-  1
hs_mode <- "switch"
host_limit <- 1
host_lambda <- 1


### Changing Parameters
symb_lambda <- args[1]
cosp_rate <- args[2]
host_shift_rate <- args[3]


symb_lambda <- 1
cosp_rate <- 1
host_shift_rate <- 1






cophylo <- treeducken::sim_cophyBD(hbr = host_lambda,
                       hdr = host_mu,
                       cosp_rate = cosp_rate,
                       host_exp_rate = host_shift_rate,
                       sdr = symb_mu,
                       sbr = symb_lambda,
                       numbsim = numb_replicates,
                       time_to_sim = time,
                       hs_mode = hs_mode,
                       host_limit = host_limit)


save <- cophylo

# drop tips that are unassociated

for ( j in 1:length(cophylo)){
  tip <- NULL
  keep <- NULL
  AssocationMat <- cophylo[[j]]$association_mat
  for (i in 1:length(rownames(AssocationMat))){
    chars <- unique(AssocationMat[i,])
    if (length(chars) == 1  && chars == 0) {
      tip <- rbind(tip, rownames(AssocationMat)[i])
    } else{ keep <- rbind(keep, rownames(AssocationMat)[i])
    
    }
  }
  if (length(tip) != 0){
    cophylo[[j]]$unpruned_tree <- cophylo[[j]]$host_tree
    cophylo[[j]]$host_tree <- ape::drop.tip(cophylo[[j]]$host_tree, tip[,1])
  }
  cophylo[[j]]$association_mat <- cophylo[[j]]$association_mat[keep,]
}



#### make sure trees are big enough 
big_trees <- list()
counter <- 1

for ( i in 1:length(cophylo)){
length_host <- length(cophylo[[i]]$host_tree$tip.label)


if ( length_host > 4) {
      big_trees[[counter]] <-  cophylo[[i]]
      counter=counter+1
     

}
}



saveRDS(save, paste0(new_dir,"/data/full_cophylo.rData"))



for ( i in 1:length(big_trees)){
  dir.create(paste0(new_dir,"/trees/tree_", i))
write.jane(big_trees[[i]], paste0(new_dir, "/trees/tree_", i, "/jane",i,".nex"))
temp <- table(big_trees[[i]]$event_history$Event_Type)
write.csv(temp, paste0(new_dir, "/trees/tree_", i, "/events",i,".csv" ))
saveRDS(big_trees[[i]], paste0(new_dir, "/trees/tree_", i,"/tree",i,".rData"))
}


saveRDS(big_trees, paste0(new_dir, "/data/big_tree.rData"))



}


main()

## total number of assications

#for (i in 1:length(big_trees)){
#print(length(which(big_trees[[i]]$association_mat == 1)))
#}



# ### max associations per host
# for ( i in 1:length(big_trees)){
#   message(paste0("tree ", i))
#   temp <- 0
# for (j in 1:length(big_trees[[i]]$association_mat[,1])){
# temp1 <- length(which(big_trees[[i]]$association_mat[j,] == 1))

# if ( temp1 > temp){
#   temp <- temp1
# }

# }

# print(temp)
# }






