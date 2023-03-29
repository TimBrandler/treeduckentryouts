#!/bin/sh
 
# allocate 4 nodes
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#
# job name
#SBATCH --job-name=Jane


# jobs always start in $HOME
# change to work directory
cd /home/woody/gwpa/gwpa005h/Cophylogenetic/Jane/

##




counter=1
num_reps=2000

s='0 1 2'    # Space separated alphabet of characters

for a in $s
do
    for b in $s
    do
        for c in $s
        do
          input=$(printf "%s%s%s\n" "$a" "$b" "$c")
          
          echo $input >> order.txt
          
         n1=$(echo $input |cut -c1)
         
         
         
         n2=$(echo $input | cut -c2)
         
         
         
         n3=$(echo $input | cut -c3)
         
        

export n1
export n2
export n3
export counter
export num_reps


sbatch scripts/CophyloAnalysis.sh


             let counter=counter+1
        done
    done
done
