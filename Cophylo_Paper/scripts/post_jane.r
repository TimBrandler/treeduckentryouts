#### Post Jane Analysis 

# dummy file to get into
Jane <- read.csv(paste0("Simulation_2_NoExtinction/trees/tree_1/final_results.txt"), sep = ":", header = FALSE)

Sims <- gtools::mixedsort(list.files("Simulation_2_NoExtinction/trees/"))
Sims <- Sims[2:length(Sims)]
Final <- matrix(nrow=length(Sims), ncol=5)
colnames(Final) <- Jane[,1]
Final <- as.data.frame(Final)
Final$NumHost <- "NA"
Final$NumSym <- "NA"
Final$NumAsso <- "NA"




for ( j in 1:length(Sims)){

number <- gsub("tree_", "",Sims[j])
Jane <- read.csv(paste0("Simulation_2_NoExtinction/trees/",Sims[j],"/final_results.txt"), sep = ":", header = FALSE)
rownames(Jane) <- Jane[,1]

TreeD <- read.csv(paste0("Simulation_2_NoExtinction/trees/", Sims[j],"/events",number,".csv"))
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
Final[j,event_names[i]] <-Results[1,event_names[i]] - Results[2,event_names[i]] 

}

tree <-readRDS(paste0("Simulation_2_NoExtinction/trees/",Sims[j],"/tree",number,".rData"))
Final [j, "NumHost"] <- length(tree$host_tree$tip.label)
Final [j, "NumSym"] <- length(tree$symb_tree$tip.label)
Final[j, "NumAsso"] <- length(which(tree$association_mat == 1))

}


#### plot in order of tree size 

Final <- Final[order(as.numeric(Final$NumHost)),]

events <- names(Final)
events <- events[1:4]


#### in order of Hosts 
Final <- Final[order(as.numeric(Final$NumHost)),]
par(mfrow=c(2,2))
for ( i in 1:length(events)){
  
  barplot(Final[,events[i]], main = events[i])
}

#### in order of Sym 
Final <- Final[order(as.numeric(Final$NumSym)),]
par(mfrow=c(2,2))
for ( i in 1:length(events)){
  
  barplot(Final[,events[i]], main = events[i])
}

#### num associations
Final <- Final[order(as.numeric(Final$NumAsso)),]
par(mfrow=c(2,2))
for ( i in 1:length(events)){
  
  barplot(Final[,events[i]], main = events[i])
}


range(as.numeric(Final$NumHost))
range(as.numeric(Final$NumSym))







  
  
