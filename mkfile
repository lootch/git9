</$PLAN9/src/mkhdr

BIN = $HOME/bin/git
SYSLIB = $HOME/lib/git
SYSMAN = $HOME/man

TARG=\
	conf\
	fetch\
	fs\
	query\
	save\
	send\
	walk

RC=\
	add\
	branch\
	clone\
	commit\
	diff\
	export\
	import\
	init\
	log\
	merge\
	pull\
	push\
	revert\
	rm

OFILES=\
	objset.$O\
	ols.$O\
	pack.$O\
	proto.$O\
	util.$O\
	ref.$O

HFILES=git.h

<$PLAN9/src/mkmany

# Override install target to install rc.
install:V:
	mkdir -p $BIN
	mkdir -p $SYSLIB
	for (i in $TARG)
		mk $MKFLAGS $i.install
	for (i in $RC)
		mk $MKFLAGS $i.rcinstall
	cp git.1 $SYSMAN/1/git
	cp gitfs.4 $SYSMAN/4/gitfs
	cp common.rc $SYSLIB/common.rc
	mk $MKFLAGS $SYSLIB/template

uninstall:V:
	rm -rf $BIN $SYSLIB

%.c %.h: %.y
	$YACC $YFLAGS -D1 -d -s $stem $prereq
	mv $stem.tab.c $stem.c
	mv $stem.tab.h $stem.h

%.c %.h: %.y
	$YACC $YFLAGS -D1 -d -s $stem $prereq
	mv $stem.tab.c $stem.c
	mv $stem.tab.h $stem.h

%.rcinstall:V:
	cp $stem $BIN/$stem
	chmod +x $BIN/$stem

$SYSLIB/template: template
	mkdir -p $SYSLIB/template
	dircp template $SYSLIB/template
