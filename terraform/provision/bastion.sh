#!/bin/bash
sudo yum -y install epel-release
sudo yum -y update
sudo yum -y install nc ansible pyOpenSSL wget git net-tools bind-utils iptables-services bridge-utils bash-completion kexec-tools sos psacct
