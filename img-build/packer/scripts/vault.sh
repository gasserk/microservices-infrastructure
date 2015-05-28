#!/bin/bash
set -ex

cat > /etc/yum.repos.d/stevendborrelli.repo <<EOF
[stevendborrelli]
name=stevendborrelli
baseurl=https://dl.bintray.com/stevendborrelli/rpm
gpgcheck=0
EOF

yum install -y vault-0.1.0-1.el7.centos.x86_64

# EOF
