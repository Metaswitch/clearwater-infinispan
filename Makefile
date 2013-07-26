# Makefile for Clearwater infrastructure packages

# this should come first so make does the right thing by default
all: deb

DEB_COMPONENT := clearwater-infinispan
DEB_MAJOR_VERSION := 1.0
DEB_NAMES := infinispan clearwater-infinispan
DEB_ARCH := all

include build-infra/cw-deb.mk

infinispan-server-5.3.0.Final-bin.zip:
	wget http://downloads.jboss.org/infinispan/5.3.0.Final/infinispan-server-5.3.0.Final-bin.zip

infinispan-server-5.3.0.Final: infinispan-server-5.3.0.Final-bin.zip
	rm -rf infinispan-server-5.3.0.Final
	unzip infinispan-server-5.3.0.Final-bin.zip
	touch infinispan-server-5.3.0.Final

deb: infinispan-server-5.3.0.Final deb-only

clean:
	rm -rf infinispan-server-5.3.0.Final-bin.zip infinispan-server-5.3.0.Final

.PHONY: all deb-only deb clean
