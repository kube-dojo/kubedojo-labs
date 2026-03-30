#!/bin/bash
kubectl create job pi-job --image=perl:5.34 -n practice -- perl -Mbignum=bpi -wle 'print bpi(2000)' 2>/dev/null || true
kubectl wait --for=condition=Complete job/pi-job -n practice --timeout=120s
