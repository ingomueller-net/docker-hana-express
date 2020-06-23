# Docker image for SAP HANA, express edition (unofficial)

[![Docker Pulls](https://img.shields.io/docker/pulls/ingomuellernet/hana-express.svg)](https://hub.docker.com/r/ingomuellernet/hana-express/)
[![Automated Build](https://img.shields.io/docker/automated/ingomuellernet/hana-express.svg)](https://hub.docker.com/r/ingomuellernet/hana-express/)
[![](https://images.microbadger.com/badges/image/ingomuellernet/hana-express.svg)](https://microbadger.com/images/ingomuellernet/hana-express)

This image is designed as starting point to easily create an docker image for SAP HANA, express edition. In comes with all prerequisites and some infrastructure to run dockerized SAP HANA, express edition, but not SAP HANA itself. It is intended for quick development on top of SAP HANA only -- not for production!

## Prequisites

* docker
* gmake
* Java (for the SAP HANA, express edition downloader)

## How to use

1. Clone the [git repository of this docker image](https://github.com/ingomueller-net/docker-hana-express).

2. Download SAP HANA express edition. This is currently done with a download you can obtain [from here](https://www.sap.com/cmp/td/sap-hana-express-edition.html). You'll need the file `hxe.tgz`, which you get by selecting `Binary Installer` as `Image` and then `Server only installer` in the list of compenents. Place the downloaded file `hxe.tgz` into the `download` folder of the git repository.

3. Create a new docker image with SAP HANA, express edition inside:

   ```bash
   make
   ```

4. Run the new image (as daemon, will be removed after it stopped):

   ```bash
   docker run --rm -d --name my_hana_instance -p 39013:39013 -p 39015:39015 -p 39018:39018 -p 4390:4390 -p 8090:8090 -p 59013:59013 -p 59014:59014 hana-express
   ```

    You can now connect to it and see how it comes up:

   ```bash
   docker exec -it my_hana_instance bash
   sudo -iu hxeadm watch HDB info
   ```

    Once it runs, you can connect to it via the command line client:

   ```bash
   docker exec -it my_hana_instance sudo -iu hxeadm hdbsql -i 90 -u SYSTEM -p HanaExpress1
   ```

## Limitations

* For now, the instance information is hardcoded:
  * System ID: HXE
  * Instance number: 90
  * Master password: HanaExpress1
  * Hostname: (some hash provided by docker)

## Upgrading to new versions

This is an attempt to document ways to trouble-shoot problems when porting this approach to new version of HANA express or OpenSUSE.

* If the installer fails, run `hdbinst` (currently in `HANA_EXPRESS_20/DATA_UNITS/HDB_SERVER_LINUX_X86_64` after downloading and extracting the installer) directly. When it fails, a path to a log file is printed, which may contain useful information.
