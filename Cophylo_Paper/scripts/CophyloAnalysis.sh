## 27.03.2023

## Laura and Brudi


### Arguments for the three events we are varying



### Rscript Simulation_Workflow




### Jane


files=$(ls -l Simulation_1_NoExtinction/ | grep '^d' | wc -l)

for i in $( seq 1 $files )
do

java -cp Jane.jar edu.hmc.jane.CLI Simulation_1_NoExtinction/tree_$i/jane$i.nex > Simulation_1_NoExtinction/tree_$i/jane_output$i.txt

tail -n 6 Simulation_1_NoExtinction/tree_$i/jane_output$i.txt > Simulation_1_NoExtinction/tree_$i/final_results.txt

#echo $i
done
