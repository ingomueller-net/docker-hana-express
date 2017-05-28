#!/bin/bash

MASTER_PWD=HanaExpress1

/install/setup_hxe.sh <<EOF
${INSTALLER_PATH}
${HOST_NAME}
${SID}
${INSTANCE}
${MASTER_PWD}
${MASTER_PWD}
y
EOF
