Bootstrap: docker
From: rockylinux:8.9

# please visit the XdMod documentation for more info!
# https://open.xdmod.org/10.5/software-requirements.html
%labels
        Author _RC_
        Version v0.0.5

%files
        site.yml /opt/_xdmod_staging_dir/site.yml
        roles/xdmod_packages/tasks/main.yml    /opt/_xdmod_staging_dir/roles/xdmod_packages/tasks/main.yml
        
%post
export LC_ALL=C.UTF-8
export MY_BASE_DIRS=/opt/_xdmod_staging_dir
#
mkdir -p ${MY_BASE_DIRS}

#change the directories

pushd ${MY_BASE_DIRS}

######## install base packages for ansible deployment 
# Note. Theres a ton of packages here to make sure we have somewhat of a sink for when patrons use this container in OOD
dnf install -y epel-release 
#dnf config-manager --enable crb

dnf -y install ansible ansible-core ansible-collection-community-general ansible-collection-community-mysql

# we have to make sure we reset this nodejs stuff here
dnf module -y reset nodejs

## set the local 
#/usr/bin/localectl set-locale LANG=en_US.UTF-8


################
# deploy the playbook
ansible-playbook --connection=local --inventory 127.0.0.1 ${MY_BASE_DIRS}/site.yml

###############
# Grab the XDmoD noarch rpm
wget https://github.com/ubccr/xdmod/releases/download/v10.5.0-1.0/xdmod-10.5.0-1.0.el8.noarch.rpm

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

%environment

export LC_ALL=C.UTF-8

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



