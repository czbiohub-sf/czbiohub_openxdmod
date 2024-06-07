#!/bin/bash 


# This script will collect slurm data from the given week, and place it inside of the xdmod instance. 

# This script will dump the slurm data to a file.
# This is useful for debugging and for tracking down issues.
# ty copilot for the help.


# Make sure we get the end time first
MY_END_TIME=$(date +'%FT%T')

# this will set the start time to 7 days ago in the format that xdmod likes
MY_START_TIME=$(date +'%FT%T' -d "$(date +'%F') - 7 days")



TZ=UTC sacct --clusters bruno --allusers \
    --parsable2 --noheader --allocations --duplicates \
    --format jobid,jobidraw,cluster,partition,qos,account,group,gid,user,uid,\
submit,eligible,start,end,elapsed,exitcode,state,nnodes,ncpus,reqcpus,reqmem,\
reqtres,alloctres,timelimit,nodelist,jobname \
    --starttime 2020-01-01T00:00:00 --endtime 2024-06-02T23:59:59 \
    > ./tmp_slurm.log

# 
# 
exit 0 
