#! /bin/bash

iw_name="wlp3s0"

airmon-ng stop $iw_name && airmon-ng stop mon0 \
&& service network-manager start

echp "*********** IWCONFIG ***************"

iwconfig