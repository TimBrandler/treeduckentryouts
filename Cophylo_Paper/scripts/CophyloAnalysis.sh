#!/bin/sh
 
# allocate 4 nodes
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#
# job name
#SBATCH --job-name=Jane$counter


cd /home/woody/gwpa/gwpa005h/Cophylogenetic/Jane/

## 27.03.2023

## Laura and Brudi


### Arguments for the three events we are varying



### Rscript Simulation_Workflow
 ## Generate our simulations using treeducken
 
 Rscript scripts/Simulation_Workflow.r $n1 $n2 $n3 $counter $num_reps



### Jane

dir=Simulation_"$counter"_NoExtinction/trees
#dir=tests

files=$(ls $dir)
#files=$(ls $dir)
mkdir $dir/malformed_trees
for i in $files
do

number=$(echo $i | sed 's/.*_//')

java -cp Jane.jar edu.hmc.jane.CLI $dir/$i/jane$number.nex > $dir/$i/jane_output$number.txt

output=$(cat $dir/$i/jane_output$number.txt | wc -l | egrep -o '[0-9]+')

if [[ $output < 1  ]];
then
mv $dir/$i $dir/malformed_trees/

else

tail -n 6 $dir/$i/jane_output$number.txt > $dir/$i/final_results.txt

fi

#echo $i
done
