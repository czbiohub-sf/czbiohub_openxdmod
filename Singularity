Bootstrap: docker
From: rockylinux:8.9

%post
# Note. Theres a ton of packages here to make sure we have somewhat of a sink for when patrons use this container in OOD

# locales
export LC_ALL=C


#check to see if our hpc directory exists, then make sure to generate cache directory for user

PREFERRED_CACHE_DIR=${SPID_USER_MYDATA_CACHE_DIR}

if [ -d '/hpc' ]
then
    PREFERRED_CACHE_DIR=${SPID_USER_MYDATA_CACHE_DIR}
else
    PREFERRED_CACHE_DIR=${SPID_USER_HOME_CACHE_DIR}
fi

if ! [ -d ${PREFERRED_CACHE_DIR} ]
then
    #make the user directory
    mkdir -p ${PREFERRED_CACHE_DIR}
fi


if ! [ -d ${PREFERRED_CACHE_DIR}/overlay ]
then
    #make the user directory
    mkdir -p ${PREFERRED_CACHE_DIR}/overlay
fi

%runscript




