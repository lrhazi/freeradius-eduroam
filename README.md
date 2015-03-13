#FreeRADIUS with EDUROAM minimal config

This is a Dockerfile and supporting config files and simple scripts, that should allow one to run a freeradius version 3 instance ready to authenticate users via EDUROAM.

### Prerequisites

- A host running Docker - See https://www.docker.io/gettingstarted/#h_installation

### How to run it directly:

```
      $ docker pull lrhazi/freeradius-eduroam
      $ docker run -d --name freeradius-eduroam \
        -p 1812:1812/udp \
        -p 1813:1813/udp \
        -v /var/log/freeradius-eduroam:/var/log/freeradius \
        -v /etc/localtime:/etc/localtime:ro \
        -e EDUROAM_SERVER_1="SEVER1" \
        -e EDUROAM_SERVER_2="SERVER2" \
        -e EDUROAM_PASSWORD="THEPASS"  \
        lrhazi/freeradius-eduroam
```

### How to use it?

Run BASH in a second instance of the image, linked to the first:

```
      $ docker run -it --rm --link freeradius-eduroam:freeradius lrhazi/freeradius-eduroam bash
      root@d0f5dc311408:~# ./radtest.sh 
      Sending Access-Request Id 245 from 0.0.0.0:50481 to 172.17.1.49:1812
          User-Name = 'bob'
          User-Password = 'hello'
          NAS-IP-Address = 172.17.1.50
          NAS-Port = 10
          Message-Authenticator = 0x00
      Received Access-Accept Id 245 from 172.17.1.49:1812 to 172.17.1.50:50481 length 32
          Reply-Message = 'Hello, bob'
      root@d0f5dc311408:~# 
      
      root@d0f5dc311408:~# ./test.sh <A VALID USERNAME @ an EDUROAM instituation> <USER's PASSWORD>
      Reading configuration file 'test.conf'
      Line: 1 - start of a new network block
      eapol_sm_cb: success=1
      EAPOL: Successfully fetched key (len=32)
      PMK from EAPOL - hexdump(len=32): 54 0b 6d 07 08 b8 ac 94 81 fc 7e c0 3e 4c 7a 8f b2 8b c1 6a 75 09 08 d4 9c 1f       27 33 86 ad b1 98
      EAP: deinitialize previously used EAP method (25, PEAP) at EAP deinit
      ENGINE: engine deinit
      MPPE keys OK: 1  mismatch: 0
      SUCCESS
      root@d0f5dc311408:~# 
```

The above two little scripts just show example usage of radtest command, to test the only predefined user in the freeradius setup, user bob, with password hello, and a test of eduroam, using eapol_test, which is bundled in the image.


### How to customize it:

Clone the project and edit the config files under files/etc directory, then rebuild the image.
Included are two little helper scripts, rebuild and restart.

/files/etc.ORG is the original /etc/freeradius/ directory. To see the few customizations I made:

```
$ # diff -r files/etc files/etc.ORG
```

Most of the changes are from this excelent howto:
https://docs.google.com/document/d/14LnsBznOw0w2fR7xgBJhzyWp1OztlKO6D5fws0XpjBI/edit?pli=1


