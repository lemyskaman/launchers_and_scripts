You insert you SD card in your Ubuntu PC and it simply does not work. Most probably your kernel has not loaded module required for recognizing your SD card.

You must run all commands in this post as root.
[Optional] : To run commands as root run command "sudo su root" and to switch user as root.

First check if your PC detects the SD Card controller.
For that run command
lspci | grep -i sd


  root@ubuntu:~# lspci | grep -i sd   
  23:00.1 System peripheral: JMicron Technology Corp. SD/MMC Host Controller (rev 30)   
  23:00.2 SD Host controller: JMicron Technology Corp. Standard SD Host Controller (rev 30)   

As you can see above, my PC recognised JMicron SD Card controller.

To make your OS load module for SD Card controller, simply run these commands.



  root@ubuntu:~# echo tifm_sd >> /etc/modules   
 root@ubuntu:~# echo mmc_block >> /etc/modules   



TAKEN FROM: http://kaustubhghanekar.blogspot.com/2013/04/making-you-sd-card-work-with-your.html
