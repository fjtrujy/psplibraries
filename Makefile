.PHONY: cmakelibs pthread-embedded

all: libraries
libraries: cmakelibs pthread-embedded

cmakelibs:
	./build-cmakelibs.sh

pthread-embedded:
	rm -rf $@
	git clone --depth 1 -b psp https://github.com/fjtrujy/pthread-embedded
	$(MAKE) -C $@/platform/psp clean
	$(MAKE) -C $@/platform/psp all
	$(MAKE) -C $@/platform/psp install
	$(MAKE) -C $@/platform/psp clean

