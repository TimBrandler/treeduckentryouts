rm(list = ls())  #clean local environment !!!!!!OPTIONAL!!!!!!
library(treeducken)

# Setting the parameters + Creating the Datasets

## Datasets
                                                    #GID   #JT   #Pi      #925      #Conjuring
host_lambda <- 1.0     # host tree birth rate        #1     #1    #3.14    #1         #1.0
host_mu <- 0.5         # host tree death rate        #0     #0    #0       #0         #0.5
time <- 1.0            # time units to simulate      #1     #.7   #0.6     #.9        #1
symb_lambda <- 1.0     # symbiont tree birth rate    #1     #1    #3.14    #1         #1.0
symb_mu <- 0.5         # symbiont tree death rate    #0     #0    #0       #0         #0.5
host_shift_rate <- 1   # host expansion rate         #1     #1    #1       #1.5       #1
cosp_rate <- 1.5       # cospeciation rate           #1     #3    #1       #1.5       #1.5
numb_replicates <- 4   # number of replicates        #4     #4    #4       #4         #4

cophylo <- sim_cophyBD(hbr = host_lambda,
                           hdr = host_mu,
                           cosp_rate = cosp_rate,
                           host_exp_rate = host_shift_rate,
                           sdr = symb_mu,
                           sbr = symb_lambda,
                           numbsim = numb_replicates,
                           time_to_sim = time)
par(mfrow=c(2,2))
plot(cophylo[[1]], col = "orange", lty = "dotted")
plot(cophylo[[2]], col = "orange", lty = "dotted")
plot(cophylo[[3]], col = "orange", lty = "dotted")
plot(cophylo[[4]], col = "orange", lty = "dotted")
par(mfrow=c(1,1))

######## Get event types and association matrices

relevents <- cophylo[[]][["event_history"]][["Event_Type"]]   #specify wich dataset (1,2,3....) in [[]] (also for below)
relevents

assocrel<- association_mat(cophylo[[]])
assocrel

######## Drop extinct Lineages (if necessary...)

h_woecophy <- drop_extinct(host_tree(cophylo[[]]))
s_woecophy <- drop_extinct(symb_tree(cophylo[[]]))

######## Writing the Nexus Files (w/o extinctions) for Jane/FigTree.....

setwd("C:/Users/timbr/Paleobiology/SymbCophy/nex_files")  #set your path!
h_tree <- host_tree(cophylo[[]])
s_tree <- symb_tree(cophylo[[]])

write.nexus(h_tree, file = "")              # specify a name (smth funny) (same for below)
write.nexus(s_tree, file = "")

####### OR if u needed to drop extinct lineages go here

setwd("C:/Users/timbr/Paleobiology/SymbCophy/nex_files")  #set your path!
write.nexus(h_woecophy, file = "")
write.nexus(s_woecophy, file = "")

#######################

library(readxl)
dat <- read_excel("C:/Users/timbr/Paleobiology/SymbCophy/TREEvsJane.xlsx", 
                         sheet = "Tabelle2")
View(dat)

GID1 <- subset(dat, Dataset == "GID1")
GID2 <- subset(dat, Dataset == "GID2")
GID3 <- subset(dat, Dataset == "GID3")
GID4 <- subset(dat, Dataset == "GID4")
JT1 <- subset(dat, Dataset == "JT1")
JT2 <- subset(dat, Dataset == "JT2")
JT3 <- subset(dat, Dataset == "JT3")
JT4 <- subset(dat, Dataset == "JT4")
Pi1 <- subset(dat, Dataset == "Pi1")
Pi2 <- subset(dat, Dataset == "Pi2")
Pi3 <- subset(dat, Dataset == "Pi3")
Pi4 <- subset(dat, Dataset == "Pi4")
Ninetofive1 <- subset(dat, Dataset == "925_1")
Ninetofive2 <- subset(dat, Dataset == "925_2")
Ninetofive3 <- subset(dat, Dataset == "925_3")
Ninetofive4 <- subset(dat, Dataset == "925_4")


