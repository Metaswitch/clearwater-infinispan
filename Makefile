# Makefile for Clearwater infrastructure packages

# this should come first so make does the right thing by default
all: deb

DEB_COMPONENT := clearwater-infinispan
DEB_MAJOR_VERSION := 1.0
DEB_NAMES := infinispan clearwater-infinispan
DEB_ARCH := all

include build-infra/cw-deb.mk

infinispan-5.2.1.Final-all.zip:
	wget http://downloads.jboss.org/infinispan/5.2.1.Final/infinispan-5.2.1.Final-all.zip

infinispan-5.2.1.Final-all: infinispan-5.2.1.Final-all.zip
	rm -rf infinispan-5.2.1.Final-all
	unzip infinispan-5.2.1.Final-all.zip
	touch infinispan-5.2.1.Final-all

deb: infinispan-5.2.1.Final-all deb-only

clean:
	rm -rf infinispan-5.2.1.Final-all.zip infinispan-5.2.1.Final-all

.PHONY: all deb-only deb clean
