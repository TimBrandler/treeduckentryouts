#### Post Jane Analysis 

# dummy file to get into
Jane <- read.csv(paste0("Simulation_1_NoExtinction/tree_1/final_results.txt"), sep = ":", header = FALSE)

Sims <- list.files("Simulation_1_NoExtinction/")
Sims <- Sims[2:length(Sims)]
Final <- matrix(nrow=length(Sims), ncol=5)
colnames(Final) <- Jane[,1]


j=3

for ( j in 1:length(Sims)){

Jane <- read.csv(paste0("Simulation_1_NoExtinction/tree_",j,"/final_results.txt"), sep = ":", header = FALSE)
rownames(Jane) <- Jane[,1]

TreeD <- read.csv(paste0("Simulation_1_NoExtinction/tree_",j,"/events",j,".csv"))
TreeD <- TreeD[,2:3]

### Tree to Jane 


for ( i in 1:length(TreeD[,1])){
if (TreeD[i,1] == "CSP"){
  TreeD[i,1] <- "Cospeciation"
} else if(TreeD[i,1] == "SSP"){
  TreeD[i,1] <- "Duplication"
} else if(TreeD[i,1] == "MTB"){
  TreeD[i,1] <- "Loss"
} else if(TreeD[i,1] == "SHE"){
  TreeD[i,1] <- "Host Switching"
} else if(TreeD[i,1] == "SX"){
  TreeD[i,1] <- "Failure to Diverge"
} 
}

# make row names the events 
rownames(TreeD) <- TreeD[,1]

event_names <- Jane[,1]
Results <- matrix(nrow = 2, ncol= 5)
rownames(Results) <- c("Jane", "TreeDucken")
colnames(Results) <- event_names


for (i in 1:length(event_names)){

Results[1,event_names[i]] <- Jane[event_names[i],2]
Results[2,event_names[i]] <- TreeD[event_names[i],2]


}

Results[is.na(Results)] <- 0
### Subtract Jane value from TreeDucken value 


for ( i in 1:length(Results[1,])){
Final[j,event_names[i]] <-Results[2,event_names[i]] - Results[1,event_names[i]] 

}


}





  
  
