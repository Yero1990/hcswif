#! /bin/bash

#code usage:  ./run_swif.sh [options]
#where [options] ---> status,  delete

workflow_name="KaonLT_Helicity_KIN-1"

#Various optional flags to add to hcswif workflow
mode=" --mode command "
shell_type="--shell bash"
shell_script=" --command file /u/group/c-kaonlt/USERS/cyero/hcswif/my_command_list_hel.txt" 
time="--time 172800"   #max run time per job in seconds allowed before killing jobs (at most 24 hours per job, as each is 5 million events)
disk_usage=" --disk 3000000000 "   #in bytes (or 1 Gb default). (1 Gb per job currently used.)
ram=" --ram 3000000000 "
cpu_cores=" --cpu 8"   #number of cpu cores requested 
project=" --project c-comm2017 "
workflow=" --name $workflow_name"


CMD="python3 hcswif.py $mode $shell_script $time $disk_usage $cpu_cores $project $workflow"
#echo $CMD

view_file="python3 -m json.tool ${workflow_name}.json"
#echo $view_file
import="swif import -file ${workflow_name}.json"                
                                                                                                                                                              
#echo $import
run="swif run $workflow_name"
#echo $run

#Execute the commands to create and run a workflow
eval ${CMD}

#Change directories
cd_cmd="cd hcswif_output"
eval ${cd_cmd}

eval ${view_file}
eval ${import}
eval ${run}



#DELETING A WORKFLOW
DEL_CMD="swif cancel -workflow $workflow_name -delete"
#VIEWING THE WORKFLOW STATUS
STATUS_CMD="swif status $workflow_name"

usr_flag=$1
#echo $DEL_FLOW
if [ "$usr_flag" = "delete" ]
then 
    eval ${DEL_CMD}

elif [ "$usr_flag" = "status" ]
then
    eval ${STATUS_CMD}
    
else
    echo Everything OK!
fi
