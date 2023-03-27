setwd("Desktop/PhD/Cophylo/")
setwd("treeduckentryouts/Cophylo_Paper/")


new_dir <- "Simulation_1_NoExtinction"
dir.create(new_dir)

library(devtools)
install_github("wadedismukes/treeducken")
library(treeducken)


numb_replicates <- 300

### Constant Parameters
host_mu <-  0  
symb_mu <- 0  
time <-  1
hs_mode <- "switch"
host_limit <- 1
host_lambda <- 1


### Changing Parameters
symb_lambda <- 1
cosp_rate <- 1
host_shift_rate <- 1





cophylo <- sim_cophyBD(hbr = host_lambda,
                       hdr = host_mu,
                       cosp_rate = cosp_rate,
                       host_exp_rate = host_shift_rate,
                       sdr = symb_mu,
                       sbr = symb_lambda,
                       numbsim = numb_replicates,
                       time_to_sim = time,
                       hs_mode = hs_mode,
                       host_limit = host_limit)

#par(mfrow=c(2,2))
plot(cophylo[[1]], col = "orange", lty = "dotted")
plot(cophylo[[2]], col = "orange", lty = "dotted")
plot(cophylo[[3]], col = "orange", lty = "dotted")
plot(cophylo[[4]], col = "orange", lty = "dotted")
plot(cophylo[[37]], col = "orange", lty = "dotted")

#par(mfrow=c(1,1))

save <- cophylo


#table(cophylo[[1]]$event_history$Event_Type)



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
    cophylo[[j]]$host_tree <- drop.tip(cophylo[[j]]$host_tree, tip[,1])
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



saveRDS(save, paste0(new_dir,"/full_cophylo.rData"))



for ( i in 1:length(big_trees)){
  dir.create(paste0(new_dir,"/tree_", i))
write.jane(big_trees[[i]], paste0(new_dir, "/tree_", i, "/jane",i,".nex"))
temp <- table(big_trees[[i]]$event_history$Event_Type)
write.csv(temp, paste0(new_dir, "/tree_", i, "/events",i,".csv" ))
saveRDS(big_trees[[i]], paste0(new_dir, "/tree_", i,"/tree",i,".rData"))
}










