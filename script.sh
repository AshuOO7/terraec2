#!/bin/bash

cd /root/test_task/
terraform init
terraform plan
terraform apply -auto-approve
z=$(cat /root/test_task/data.txt)
echo -e "****************** Jenkins Default ADMIN Password *********************"
ssh -i /root/test_task/terrakey.pem ubuntu@$z 'sudo cat /var/lib/jenkins/secrets/initialAdminPassword'
echo -e "***********************************************************************"
