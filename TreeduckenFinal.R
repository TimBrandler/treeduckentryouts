rm(list = ls())  #clean local environment !OPTIONAL!
library(treeducken)

# Setting the parameters + Creating the Datasets

#set.seed()               #if a certain cophylogeny is desired set.seed() allows treeducken to reproduce this cophylogeny 

## Datasets
                                                    #GID   #JT   #Pi      #925      #Conjuring   #Randomness
host_lambda <- 3.14    # host tree birth rate        #1     #1    #3.14    #1         #1.0          #2
host_mu <-  0          # host tree death rate        #0     #0    #0       #0         #0.5          #1.5
time <-  0.6           # time units to simulate      #1     #.7   #0.6     #.9        #1            #1
symb_lambda <- 3.14    # symbiont tree birth rate    #1     #1    #3.14    #1         #1.0          #2
symb_mu <- 0           # symbiont tree death rate    #0     #0    #0       #0         #0.5          #1.5
host_shift_rate <- 1   # host expansion rate         #1     #1    #1       #1.5       #1            #1
cosp_rate <- 1         # cospeciation rate           #1     #3    #1       #1.5       #1.5          #2
numb_replicates <- 4   # number of replicates        #4     #4    #4       #4         #4            #50

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

######## Get and export event types and association matrices

relevents <- cophylo[[]][["event_history"]][["Event_Type"]]   #specify wich cophylogeny (1,2,3....) in [[]] (also for below)
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
#some clunky commands, currently working on a for-loop :)

length(cophylo[[]][["event_history"]][["Event_Type"]])
length(cophylo[[]][["symb_tree"]][["tip.label"]])+length(cophylo[[]][["host_tree"]][["tip.label"]])


#######################

library(readxl)
dat <- read_excel("C:/Users/timbr/Paleobiology/SymbCophy/TREEvsJane.xlsx", # get your file!
                         sheet = "Tabelle2")
View(dat)

attach(dat)

par(mfrow=c(2,2))
barplot(formula = (CSP-Cospeciation) ~ Dataset, data=dat, ylab = "Δ Cospeciation", col = "purple", cex.names= 0.4 )
barplot(formula = (SSP-Duplication) ~ Dataset, data=dat, ylab ="Δ Symbiont speciation", col = "blue", cex.names= 0.4)
barplot(formula = (SHE-HostSwitch) ~ Dataset, data=dat, ylab ="Δ Host Switching", col = "green", cex.names= 0.4)
barplot(formula = (HSP-Failure2Diverge) ~ Dataset, data=dat, ylab= "Δ Host Speciation", col = "red", cex.names= 0.4 )
par(mfrow=c(1,1))

detach(dat)
################# Just some basics
mean(CSP - Cospeciation)
sd(CSP - Cospeciation)
mean(SSP - Duplication)
sd(SSP - Duplication)
mean(SHE - HostSwitch)
sd(SHE - HostSwitch)
mean(HSP - Failure2Diverge)
sd(HSP - Failure2Diverge)


####################### Start of the analysis of randomness, not much to see here yet just some basics

data <- read_excel("C:/Users/timbr/Paleobiology/SymbCophy/TREEvsJane.xlsx", 
                  sheet = "Tabelle3")
mean(data$Eventcount)
sd(data$Eventcount)
min(data$Eventcount)
max(data$Eventcount)
