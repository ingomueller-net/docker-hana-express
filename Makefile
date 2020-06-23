INSTALLER_IMAGE=ingomuellernet/hana-express
TEMP_CONTAINER=hana-express-installer
FINAL_IMAGE=hana-express

all: hana_express_image

download/setup_hxe.sh: download/hxe.tgz
	cd download && tar -mxf ../$^

local_installer_image:
	docker build . -t $(INSTALLER_IMAGE)

hana_express_image: download/setup_hxe.sh
ifdef LOCAL_IMAGE
	INSTALLER_IMAGE=$(LOCAL_IMAGE)
	docker build . -t $(INSTALLER_IMAGE)
endif
	docker run -it -v $(PWD)/download:/install --name $(TEMP_CONTAINER) $(INSTALLER_IMAGE)
	docker commit --change 'CMD ["/opt/start-hxe.sh"]' $(TEMP_CONTAINER) $(FINAL_IMAGE)
	docker container rm $(TEMP_CONTAINER)

run:
	docker run --rm -d -p 39013:39013 -p 39015:39015 -p 39018:39018 -p 4390:4390 -p 8090:8090 -p 59013:59013 -p 59014:59014 $(FINAL_IMAGE)
