## 27.03.2023

## Laura and Brudi


### Arguments for the three events we are varying



### Rscript Simulation_Workflow




### Jane

dir=Simulation_2_NoExtinction/trees
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
