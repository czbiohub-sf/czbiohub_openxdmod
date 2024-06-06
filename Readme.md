# CZ-Biohub Network XDmod Project
This project is to establish Open-XDmod for accounting on the Bruno HPC cluster


## Requirements

* add an ansible inventory so that image can be deployed on bare metal servers.
* automate ingestion process to check time created via `stat`, and the `diff` between files.
* Database utilizing VAST, or other clustered file systems in mount
* Deployed as a tab in Bruno OOD for everyone to view
* tested on old ondemand server first, before depoyment on main ondemand server
* Slurm needs to be bind mounted into the environment
* protect page through a reverse proxy of the web application
* ~~Zaphod as a host~~
* ~~Apptainer service~~
* ~~Deployed using config management~~
* ~~Rockylinux or Centos 7 as the operating system~~
* ~~Packages need to be deployed and resolved properly.~~
* ~~needs to be hosted on the biohubs main github page~~

## Abstract 
We need to have OpenXDmod available not only for our shareholder in San Francisco, but also our share holder at other biohubs .tm. 

## Errata 
* Requested by Rosio. Try to get done soonish.
* Will be helpful: https://httpd.apache.org/docs/2.4/en/howto/reverse_proxy.html
* added to czbiohub-sf github repository
