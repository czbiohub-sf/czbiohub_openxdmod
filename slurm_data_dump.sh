#!/bin/bash 

# This script will dump the slurm data to a file.
# This is useful for debugging and for tracking down issues.
# ty copilot for the help.

TZ=UTC sacct --clusters bruno --allusers \
    --parsable2 --noheader --allocations --duplicates \
    --format jobid,jobidraw,cluster,partition,qos,account,group,gid,user,uid,\
submit,eligible,start,end,elapsed,exitcode,state,nnodes,ncpus,reqcpus,reqmem,\
reqtres,alloctres,timelimit,nodelist,jobname \
    --starttime 2020-01-01T00:00:00 --endtime 2024-06-02T23:59:59 \
    >./tmp_slurm.log