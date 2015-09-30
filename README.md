# Apache with HTTP/2 Auto Installer

This script contains all necessary for install and execute automatically Apache with full HTTP/2 support (h2 & h2c). 

## Requirements

This script has been tested with [Ubuntu 14.04 LTS](http://www.ubuntu.com/download/server "Ubuntu 14.04 LTS"). All necessary dependencies are included inside the script.

## How to install?

The installation process is very simple. You only have to execute the following command

```bash
./apache.sh
```

During the installation process, this script will ask you for the "root" password. It's necessary provide it to make the Apache installation correctly and its dependencies.

## Details

This script will install the Apache with full HTTP/2 suppor on your home directory:

```bash
~/apache2.5/
```

On the other hand, the following tools will be installed on your system with Apache.

 - OpenSSL 1.0.2
 - cURL 7.44
 - NGHTTP2: 1.3.2

Finally, Apache 2.5-DEV is installed with PHP5.


##Licensing
Please see LICENSE file.


##Credits

Madrid, 09/30/2015,

Javier Gusano Martínez, Hewlett-Packard Enterprise 
