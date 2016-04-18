# Generated automatically from Makefile.in by configure.
# Main Dada Engine makefile

# destination for compiled binaries



# prefix	= /usr/local
prefix	= $(HOME)
exec_prefix	= ${prefix}
bindir	= ${exec_prefix}/bin
datadir	= ${prefix}/lib
infodir	= ${prefix}/info
mandir	= ${prefix}/man

SHELL	= /bin/sh

INSTALL_DIRS	= ${bindir} ${datadir}/dada/include ${infodir} ${mandir}/man1

cpp 	= /lib/cpp

INSTALL	=	/usr/bin/install -c

all:	dada
	
	$(MAKE) -C src
	$(MAKE) -C doc

install:	$(INSTALL_DIRS) \
	$(bindir)/pb ${bindir}/dada ${infodir}/dada.info
	$(INSTALL) -m 0644 include/*.pbi ${datadir}/dada/include
	$(INSTALL) -m 0644 man/*.1 ${mandir}/man1
	@echo 'Installation complete.'

${bindir}/pb:	src/pb
	$(INSTALL) -s src/pb ${bindir}

${bindir}/dada:	dada
	sed -e '/PREFIX=/cPREFIX=$(prefix)' dada > ${bindir}/dada
	chmod 755 ${bindir}/dada

${infodir}/dada.info:	doc/dada.info
	$(INSTALL) -m 0644 doc/dada.info ${infodir}

# dependencies for installation

$(INSTALL_DIRS):
	$(SHELL) mkdirs.sh $@


clean:
	rm -f *~
	( cd src ; make clean )
	( cd doc ; make clean )
	( cd regex ; make clean )
distclean:	clean
	rm -f config.cache config.log config.status
	rm -f src/Makefile doc/Makefile regex/Makefile Makefile src/config.h inst


dada.tar.gz:
	tar cvf dada.tar src/*.[chxy] man scripts/*.pb doc/*.texi include/*.pbi dadaprolog.ps README COPYING regex/*.[ch37] regex/sys/* regex/COPYRIGHT install-sh
	gzip -9c dada.tar >dada.tar.gz
	rm dada.tar

test:
	cpp -Iinclude scripts/pomo.pb | sed -e '/^#/d' | ./src/pb > /dev/null
	cpp -Iinclude scripts/pomo.pb | sed -e '/^#/d' | ./src/pb > /dev/null
	cpp -Iinclude scripts/pomo.pb | sed -e '/^#/d' | ./src/pb > /dev/null
	cpp -Iinclude scripts/silly-word.pb | sed -e '/^#/d' | ./src/pb > /dev/null
