#!/usr/bin/env bash
#
# This requires that local::lib be installed in $PLENV_ROOT, e.g.
#    cpanm -l $(plenv root) local::lib
# and that a modified plenv-use which creates the PLENV_USE_LIB
# variable is installed in plenv-contrib/bin/plenv-use


if [ -n "$PLENV_USE_LIB" ]; then
    lib=${PLENV_VERSION}@${PLENV_USE_LIB}
    local_lib=$PLENV_ROOT/libs/$lib

    if [ ! -d "$local_lib" ]; then

	echo "lib $lib doesn't exist. Create it first with 'PLENV_USE_LIB= plenv lib create $lib'"
	exit 1
    fi

    eval $($(plenv which perl) -I$(plenv root)/lib/perl5 -Mlocal::lib -e 'local::lib->print_environment_vars_for(q['"$local_lib"'],(\$local::lib::VERSION > 1.008026) ? () : (0, local::lib->INTERPOLATE_ENV));')
fi
