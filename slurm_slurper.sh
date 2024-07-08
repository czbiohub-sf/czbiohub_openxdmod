#!/bin/bash


# Based upon work from Paul Williams 
# https://github.com/jtfrey/xdmod-container/blob/master/XDMoD-start

#sets up a defacto logger for testing 


function czbh_xdmod_logging_output() 
{
 
# this will set up the logging in a crude LANL way
MY_LOG_DIRECTORY=/tmp/czbiohub_xdmod_log

exec > ${MY_LOG_DIRECTORY} 2>&1
set -x 
date 



}


function czbh_xdmod_debug_output() 
{
  echo "starting the debug process" 

    function xdmod-shredder() 
    {
      echo "this is the xdmod-shredder function and the parameters are:" 
      echo $@
    }

    function xdmod-ingestor() 
    {
      echo "this is the xdmod-shredder function and the parameters are:"
      echo $@
    }


# export the functions here and hopefully it will act like an application.. 
  export -f xdmod-shredder
  export -f xdmod-ingestor

}




set -x 

# test logging function
# czbh_xdmod_logging_output
czbh_xdmod_debug_output


echo "Starting the xdmod slurper"

#sleep time
CZ_XDMOD_SLEEP_PERIOD=$(( 60 * 60 * 1))  #set it to 1 hour. 

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
                
                zstd -T0 -d "${infile}" #go ahead and uncompress the file before processing # we probably need to do some good logic here.. blah
                
                innerFileBuffer=$( echo ${infile}| sed 's/.zst//g') #change the name of the current file we are working with

                ingest_output="$(xdmod-shredder -r ${CZ_CLUSTER_NAME} -f ${CZ_RESOURCE_LOG_FORMAT} -i "${innerFileBuffer}" 2>&1)"


                if [ $? -ne 0 ]; then
                    mv "${infile}" ${CZ_ERR_DIR}
                    echo "unable to process ${infile}" "$ingest_output"
                else
                    mv "${infile}" ${CZ_OUT_DIR}
                    echo "successfully processed ${infile}"
                    out_count=$((out_count+1))
                fi
                #lets clean up the uncompressed file 
                rm -f ${innerFileBuffer} #clean up the file after we are done with it.
             
             fi 
             sleep 1 #sleep for a second, so we don't hog all of the cpu
        done

      if [ $out_count -gt 0 ]; then
      
          echo "This is where we run the ingestor"
          # running the ingestor below 
          xdmod-ingestor

          if [ $? -ne 0 ]; then
              ingest_log "There was a failure running xdmod-ingestor.\nPlease check the logs."
          fi
        
        sleep 1 #minor sleep for a second 

      fi
    
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
