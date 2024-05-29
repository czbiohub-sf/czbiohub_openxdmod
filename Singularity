Bootstrap: docker
From: rockylinux:8.9

%labels



%post
export LC_ALL=C

# Note. Theres a ton of packages here to make sure we have somewhat of a sink for when patrons use this container in OOD
dnf install -y epel-release ansible ansible-core

# we have to make sure we reset this nodejs stuff here
dnf module -y reset nodejs
# deploy the playbook

# ansible-playbook -i "localhost," -c local /opt/ood/ood-ansible/roles/ood_portal/files/ood_portal.yml

##
## enable apache mods here 
## 

PREFERRED_CACHE_DIR=${SPID_USER_MYDATA_CACHE_DIR}

if [ -d '/hpc' ]
then

else

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




