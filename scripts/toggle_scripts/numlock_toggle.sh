#!/bin/bash

#Author: Lemys Lopez @lemyskaman

#a bash script to toggle keyboard numlock and notifiying its status

numlockx toggle 
notify-send "$( numlockx status )"
