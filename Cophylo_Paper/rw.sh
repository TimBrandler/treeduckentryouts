

counter=1
num_reps=20

s='0 1 2'    # Space separated alphabet of characters

for a in $s
do
    for b in $s
    do
        for c in $s
        do
          input=$(printf "%s%s%s\n" "$a" "$b" "$c")
          
         n1=$(echo $input |cut -c1)
         
         
         
         n2=$(echo $input | cut -c2)
         
         
         
         n3=$(echo $input | cut -c3)
         
         
  
      
 ## Generate our simulations using treeducken
 
 Rscript scripts/Simulation_Workflow.r $n1 $n2 $n3 $counter $num_reps
 
 
 ### Jane
 
 dir=Simulation_"$counter"_NoExtinction/trees

files=$(ls $dir)
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
done
            
             let counter=counter+1
        done
    done
done
