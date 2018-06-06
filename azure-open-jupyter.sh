#!/bin/bash

list=`ssh -i ${privateKeyPath} ubuntu@${instanceId} 'sudo nvidia-docker exec tfbook jupyter notebook list'`
url=`echo $list | grep http | sed -e "s/localhost/${instanceId}/g" | sed -e "s/:8888//g" | awk '{print $4}'`
echo $url
open $url
