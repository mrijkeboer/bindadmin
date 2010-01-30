#!/bin/sh

# Copyright (c) 2009, Martijn P. Rijkeboer <martijn@bunix.org>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

SERVER='http://localhost:3000'
SERVERNAME="ns1"
PASSWORD="test1234"

BINDADMIN_DIR="/var/spool/bindadmin"
TARGET_ZONES_DIR="${BINDADMIN_DIR}/zones"
TARGET_CONFIG="${BINDADMIN_DIR}/zones.conf"
TEMP_ZONES_DIR="${BINDADMIN_DIR}/zones-temp"
TEMP_CONFIG="${BINDADMIN_DIR}/zones.conf-temp"
CONFIG_SCRIPT_NAME="config.sh"

LOCK_FILE="${BINDADMIN_DIR}/lock"

check_cmd() {
	if ! which $1 >/dev/null; then
		echo "Can't find command: $1"
		exit 1
	fi
}

check_cmd basename
check_cmd cat
check_cmd chmod
check_cmd chown
check_cmd id
check_cmd mkdir
check_cmd mv
check_cmd named-checkzone
check_cmd rm
check_cmd rndc
check_cmd touch
check_cmd wget

PROG=`basename $0`

# Check if root
if [ "`id -u`" != "0" ]; then
	echo "${PROG}: must be run as root"
	exit 1
fi

# Check if another instance is still running
if [ -f ${LOCK_FILE} ]; then
	echo "${PROG}: an other instance is still running"
	exit 1
else
	touch ${LOCK_FILE}
fi

# Check if BINDADMIN_DIR exists
if [ ! -d ${BINDADMIN_DIR} ]; then
	mkdir -p ${BINDADMIN_DIR}
fi

# Check if TARGET_ZONES_DIR exists
if [ ! -d ${TARGET_ZONES_DIR} ]; then
	mkdir -p ${TARGET_ZONES_DIR}
fi

# Check if TEMP_ZONES_DIR exists
if [ ! -d ${TEMP_ZONES_DIR} ]; then
	mkdir -p ${TEMP_ZONES_DIR}
fi

# Set rights
chown root ${BINDADMIN_DIR}
chmod 0700 ${BINDADMIN_DIR}

# Change directory
cd ${BINDADMIN_DIR}

# Check if timestamp file exists
if [ ! -f timestamp ]; then
	echo "0" > timestamp
fi

# Get last timestamp
LAST_TIMESTAMP=`cat timestamp`

# Get new configuration
wget -q -O ${CONFIG_SCRIPT_NAME} ${SERVER}/bind/configs/${SERVERNAME}/${PASSWORD}/${LAST_TIMESTAMP}

# Execute new configuration
sh ${CONFIG_SCRIPT_NAME}

# Check zone files and move them into place
cd ${TEMP_ZONES_DIR}
for file in `ls`; do
	named-checkzone -q ${file} ${file}
	if [ "$?" = "0" ]; then
		mv ${file} ${TARGET_ZONES_DIR}
	fi
done

# Move zones.conf into place
cd ${BINDADMIN_DIR}
mv ${TEMP_CONFIG} ${TARGET_CONFIG}

# Reload bind config
rndc reload

# Clean up
rm -f ${CONFIG_SCRIPT_NAME}
rm -f ${LOCK_FILE}

exit 0
