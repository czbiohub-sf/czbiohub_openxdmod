#!/bin/bash


# Based upon work from Paul Williams 
# https://github.com/jtfrey/xdmod-container/blob/master/XDMoD-start
#sleep time
CZ_XDMOD_SLEEP_PERIOD="1h" #set it to 1 hour. 

# base, input/output, and error directories 
MY_BASE_DIRS=/opt/czbh_xdmod_dir
CZ_IN_DIR=${MY_BASE_DIRS}/in_dir
CZ_OUT_DIR=${MY_BASE_DIRS}/out_dir
CZ_ERR_DIR=${MY_BASE_DIRS}/error_dir

# cluster name and resource log format
CZ_CLUSTER_NAME="Bruno"
CZ_RESOURCE_LOG_FORMAT="slurm"



while true; do 
# main game loop 
  out_count=0
        # we want to make sure that we are only ingesting 
        for infile in ${CZ_IN_DIR}/*.zst; do
             if [ -f "${infile}" ]; then
                ingest_output="$(xdmod-shredder -r ${CZ_CLUSTER_NAME} -f ${CZ_RESOURCE_LOG_FORMAT} -i "${infile}" 2>&1)"


                if [ $? -ne 0 ]; then
                    mv "${infile}" ${CZ_ERR_DIR}
                    echo "unable to process ${infile}" "$ingest_output"
                else
                    mv "${infile}" ${CZ_OUT_DIR}
                    echo "successfully processed ${infile}"
                    out_count=$((out_count+1))
                fi
             fi 
        done


    
    # sleep and wait
  sleep ${CZ_XDMOD_SLEEP_PERIOD}
done 



#            if [ -f "$infile" ]; then
#                ingest_output="$(xdmod-shredder -r $CLUSTER_NAME -f $RESOURCE_LOG_FORMAT -i "$infile" 2>&1)"
#                if [ $? -ne 0 ]; then
#                    mv "$infile" /var/lib/XDMoD-ingest-queue/error
#                    ingest_log "unable to process $infile" "$ingest_output"
#                else
#                    mv "$infile" /var/lib/XDMoD-ingest-queue/out
#                    ingest_log "successfully processed $infile"
#                    out_count=$((out_count+1))
#                fi
#            fi
#
#
#
#        if [ $out_count -gt 0 ]; then
#            logfile="xdmod-ingestor-$(date +%Y%m%dT%H%M%S).log"
#            xdmod-ingestor > /var/lib/XDMoD-ingest-queue/out/${logfile} 2>&1
#            if [ $? -ne 0 ]; then
#                ingest_log "failure running xdmod-ingestor, see ${logfile}"
#            fi
#        fi
