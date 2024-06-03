Bootstrap: docker
From: rockylinux:8

# please visit the github page for more information
# https://github.com/ubccr/xdmod

%labels
        Author _RC_
        Version v0.0.5

%setup
    tar -cvvf payload.tar site.yml roles/*

%files
        payload.tar /opt/_xdmod_staging_dir/payload.tar
        CZBioHub-Mirrors.repo /etc/yum.repos.d/CZBioHub-Mirrors.repo
%post
export LC_ALL=C.UTF-8
export MY_BASE_DIRS=/opt/_xdmod_staging_dir
#
mkdir -p ${MY_BASE_DIRS}

#change the directories

pushd ${MY_BASE_DIRS}

######## install base packages for ansible deployment 
# Note. Theres a ton of packages here to make sure we have somewhat of a sink for when patrons use this container in OOD



#delete all rocky repos
rm -rf /etc/yum.repos.d/Rocky*

#enable powertools repo
#sed -i 's/enabled\=0/enabled\=1/g' /etc/yum.repos.d/Rocky-PowerTools.repo
#sed -i 's/enabled\=0/enabled\=1/g' /etc/yum.repos.d/Rocky-Plus.repo

#this is left over crap from Rocky 9 testing
#sed -i 's/enabled\=0/enabled\=1/g' /etc/yum.repos.d/rocky-addons.repo
#sed -i 's/enabled\=0/enabled\=1/g' /etc/yum.repos.d/rocky-extras.repo
#sed -i 's/enabled\=0/enabled\=1/g' /etc/yum.repos.d/rocky.repo

#install epel and ansible core
dnf install -y epel-release 
dnf -y install --skip-broken --nobest python3-pip ansible ansible-collection-community-general ansible-collection-community-mysql tar gzip

#pip3 install ansible

# we have to make sure we reset this nodejs stuff here
#dnf module -y reset nodejs

## set the local 
#/usr/bin/localectl set-locale LANG=en_US.UTF-8
tar xvf payload.tar

################
# deploy the playbook
ansible-playbook --connection=local --inventory 127.0.0.1 ${MY_BASE_DIRS}/site.yml

###### 
#PHP installation:
# lines are deprecated, and are now implemented in ansible playbook
#echo "extension=mongodb.so" > /etc/php.d/40-mongodb.ini

###############
# Grab the XDmoD noarch rpm
wget https://github.com/ubccr/xdmod/releases/download/v10.5.0-1.0/xdmod-10.5.0-1.0.el8.noarch.rpm

dnf install -y ./xdmod-10.5.0-1.0.el8.noarch.rpm
################

################
## enable apache mods here 
## 


# mariadb stuff right here 
chmod -R +wrx /var/log
chown -R mysql:mysql /var/log/mariadb
chmod -R +wrx /var/lib
chown -R mysql:mysql /var/lib/mysql
chmod -R +wrx /run
chown -R mysql:mysql /run/mariadb

mkdir -p /hpc

# remove this package 
dnf -y remove mariadb-gssapi-server


# create the mysql database
mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

################
# Copy configuration file to apache location
#cp /usr/share/xdmod/templates/apache.conf /etc/httpd/conf.d/xdmod.conf


%environment
export LC_ALL=C.UTF-8


%runscript
echo /dev/null 

#cd '/usr' ; /usr/bin/mysqld_safe --datadir='/var/lib/mysql'
#/usr/sbin/httpd -DFOREGROUND 


TZ=UTC sacct --clusters *cluster* --allusers \
    --parsable2 --noheader --allocations --duplicates \
    --format jobid,jobidraw,cluster,partition,qos,account,group,gid,user,uid,\
submit,eligible,start,end,elapsed,exitcode,state,nnodes,ncpus,reqcpus,reqmem,\
reqtres,alloctres,timelimit,nodelist,jobname \
    --starttime 2013-01-01T00:00:00 --endtime 2013-01-01T23:59:59 \
    >/tmp/slurm.log