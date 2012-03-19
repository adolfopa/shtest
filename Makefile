suites_root = suites

test:
	[ -n "$(suite)" ] || exit 1
	[ -d "$(suites_root)/$(suite)" ] || exit 1
	mkdir -p results
	cd $(suites_root)/$(suite) && $(MAKE) test

create:
	[ -n "$(suite)" ] || exit 1
	mkdir $(suites_root)/$(suite)
	cp Makefile.suite.in $(suites_root)/$(suite)/Makefile

clean:
	-rm -rf *~ results
