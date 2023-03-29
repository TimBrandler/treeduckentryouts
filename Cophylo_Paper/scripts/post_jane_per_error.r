### Calculate percentage error 

## +1 
Sims <- list.files("Simulation_2_NoExtinction/trees/")
Sims <- Sims[2:length(Sims)]

Jane <- read.csv(paste0("Simulation_2_NoExtinction/trees/",Sims[1],"/final_results.txt"), sep = ":", header = FALSE)

events <- Jane[,1]
events <- events[1:4]
par(mfrow=c(2,2))

for (k in 1:length(events)){ 
  
  err_Cosp <- matrix(nrow = length(Sims), ncol = 5)
  colnames(err_Cosp) <- c("treeducken", "Jane", "% error", "n Host", "n Symbiont")
  
  for (j in 1:length(Sims)) {
    
    
    number <- gsub("tree_", "",Sims[j])
    Jane <- read.csv(paste0("Simulation_2_NoExtinction/trees/",Sims[j],"/final_results.txt"), sep = ":", header = FALSE)
    rownames(Jane) <- Jane[,1]
    
    TreeD <- read.csv(paste0("Simulation_2_NoExtinction/trees/", Sims[j],"/events",number,".csv"))
    TreeD <- TreeD[,2:3]
    for ( i in 1:length(TreeD[,1])){
      if (TreeD[i,1] == "CSP"){
        TreeD[i,1] <- "Cospeciation"
      } else if(TreeD[i,1] == "SSP"){
        TreeD[i,1] <- "Duplication"
      } else if(TreeD[i,1] == "MTB"){
        TreeD[i,1] <- "Loss"
      } else if(TreeD[i,1] == "SHE"){
        TreeD[i,1] <- "Host Switch"
      } else if(TreeD[i,1] == "SX"){
        TreeD[i,1] <- "Failure to Diverge"
      } 
    }
    
    # make row names the events 
    rownames(TreeD) <- TreeD[,1]
    
    
    
    err_Cosp[j,"Jane"] <- Jane[events[k],2]
    err_Cosp[j,"treeducken"] <- TreeD[events[k],"Freq"]
    
    if(is.na(err_Cosp[j, "treeducken"])){
      err_Cosp[j, "treeducken"] <- 0
    }
    
    
    div <- err_Cosp[j, "treeducken"] + 1
    err_Cosp[j, "% error"] <- (Jane[events[k],2] - err_Cosp[j, "treeducken"])/
                                 (div)
    
    tree <-readRDS(paste0("Simulation_2_NoExtinction/trees/",Sims[j],"/tree",number,".rData"))
    err_Cosp[j, "n Host"] <- length(tree$host_tree$tip.label)
    err_Cosp[j, "n Symbiont"] <- length(tree$symb_tree$tip.label)
    
  }
  
  
  
  ##### plotting 
  
  err_Cosp <- err_Cosp[order(as.numeric(err_Cosp[,"n Host"] )),]
  
  
  barplot(err_Cosp[,"% error"], main = events[k])
  
}






#### set 0 to 1

### Calculate percentage error 
Sims <- list.files("Simulation_2_NoExtinction/trees/")
Sims <- Sims[2:length(Sims)]

Jane <- read.csv(paste0("Simulation_2_NoExtinction/trees/",Sims[1],"/final_results.txt"), sep = ":", header = FALSE)

events <- Jane[,1]
events <- events[1:4]
par(mfrow=c(2,2))

for (k in 1:length(events)){ 
 
   err_Cosp <- matrix(nrow = length(Sims), ncol = 5)
  colnames(err_Cosp) <- c("treeducken", "Jane", "% error", "n Host", "n Symbiont")
  
for (j in 1:length(Sims)) {
  

number <- gsub("tree_", "",Sims[j])
Jane <- read.csv(paste0("Simulation_2_NoExtinction/trees/",Sims[j],"/final_results.txt"), sep = ":", header = FALSE)
rownames(Jane) <- Jane[,1]

TreeD <- read.csv(paste0("Simulation_2_NoExtinction/trees/", Sims[j],"/events",number,".csv"))
TreeD <- TreeD[,2:3]
for ( i in 1:length(TreeD[,1])){
  if (TreeD[i,1] == "CSP"){
    TreeD[i,1] <- "Cospeciation"
  } else if(TreeD[i,1] == "SSP"){
    TreeD[i,1] <- "Duplication"
  } else if(TreeD[i,1] == "MTB"){
    TreeD[i,1] <- "Loss"
  } else if(TreeD[i,1] == "SHE"){
    TreeD[i,1] <- "Host Switch"
  } else if(TreeD[i,1] == "SX"){
    TreeD[i,1] <- "Failure to Diverge"
  } 
}

# make row names the events 
rownames(TreeD) <- TreeD[,1]



err_Cosp[j,"Jane"] <- Jane[events[k],2]
err_Cosp[j,"treeducken"] <- TreeD[events[k],"Freq"]

if(is.na(err_Cosp[j, "treeducken"])){
  err_Cosp[j, "treeducken"] <- 0
}

  
if (err_Cosp[j, "treeducken"] == 0 ){
  err_Cosp[j, "% error"] <- ((Jane[events[k],2] - err_Cosp[j, "treeducken"])/1)*100
} else{
err_Cosp[j, "% error"] <- ((Jane[events[k],2] - err_Cosp[j, "treeducken"])/err_Cosp[j, "treeducken"])*100
}


tree <-readRDS(paste0("Simulation_2_NoExtinction/trees/",Sims[j],"/tree",number,".rData"))
err_Cosp[j, "n Host"] <- length(tree$host_tree$tip.label)
err_Cosp[j, "n Symbiont"] <- length(tree$symb_tree$tip.label)

}
  
 

##### plotting 

err_Cosp <- err_Cosp[order(as.numeric(err_Cosp[,"n Host"] )),]

  
  barplot(err_Cosp[,"% error"], main = events[k])

}


