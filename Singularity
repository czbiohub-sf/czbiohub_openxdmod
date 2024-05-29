Bootstrap: docker
From: rockylinux:8.9

# please visit the XdMod documentation for more info!
# https://open.xdmod.org/10.5/software-requirements.html
%labels
        Author _RC_
        Version v0.0.5

%files
        site.yml /opt/_xdmod_staging_dir/site.yml
        cryosparc.sh    /cryosparc.sh
        cryosparc-server.sh     /app/cryosparc_master/bin/cryosparc-server.sh

%post
export LC_ALL=C
export MY_BASE_DIRS=/opt/_xdmod_staging_dir
#
mkdir -p ${MY_BASE_DIRS}


######## install base packages for ansible deployment 
# Note. Theres a ton of packages here to make sure we have somewhat of a sink for when patrons use this container in OOD
dnf install -y epel-release ansible ansible-core

# we have to make sure we reset this nodejs stuff here
dnf module -y reset nodejs

################
# deploy the playbook
ansible-playbook --connection=local --inventory 127.0.0.1 ${MY_BASE_DIRS}/site.yml

################
# php configuations 
pecl install mongodb
echo "extension=mongodb.so" > /etc/php.d/40-mongodb.ini

################
## enable apache mods here 
## 

################
# Debug everything here 
php -i | grep mongo

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
echo /dev/null 



