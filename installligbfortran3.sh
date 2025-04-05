#!/usr/bin/bash
#
# Install libgfortran3
# https://gist.github.com/sakethramanujam/faf5b677b6505437dbdd82170ac55322#file-install-libgfortran3-sh
#
# USE WITH CAUTION AS IT MAY UPSET gcc
#
# R.C.Stewart 2024-09-04

echo "Downloading gcc-6-base" && \
cd /tmp/ && wget http://archive.ubuntu.com/ubuntu/pool/universe/g/gcc-6/gcc-6-base_6.4.0-17ubuntu1_amd64.deb && \
echo "Downloading libgfortran3" && \
cd /tmp/ && wget http://archive.ubuntu.com/ubuntu/pool/universe/g/gcc-6/libgfortran3_6.4.0-17ubuntu1_amd64.deb && \
echo "Installing gcc-6-base" && \
cd /tmp/ && sudo dpkg -i gcc-6-base_6.4.0-17ubuntu1_amd64.deb && \
echo "Installing libgfortran3" && \
cd /tmp/ && sudo dpkg -i libgfortran3_6.4.0-17ubuntu1_amd64.deb
