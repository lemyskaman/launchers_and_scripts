#! /bin/bash

kill $(ps aux | grep 'reflect.php' | awk '{print $2}')
