.PHONY: cmakelibs libintrafont pthread-embedded

all: libraries
libraries: cmakelibs libintrafont pthread-embedded

cmakelibs:
	./build-cmakelibs.sh

libintrafont:
	rm -rf $@
	git clone --depth 1 -b master https://github.com/pspdev/libintrafont
	$(MAKE) -C $@ -f Makefile.psp
	$(MAKE) -C $@ -f Makefile.psp install
	$(MAKE) -C $@ -f Makefile.psp clean

pthread-embedded:
	rm -rf $@
	git clone --depth 1 -b psp https://github.com/fjtrujy/pthread-embedded
	$(MAKE) -C $@/platform/psp clean
	$(MAKE) -C $@/platform/psp all
	$(MAKE) -C $@/platform/psp install
	$(MAKE) -C $@/platform/psp clean
