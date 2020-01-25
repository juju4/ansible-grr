#!/bin/sh
## one script to be used by travis, jenkins, packer...

umask 022

if [ $# != 0 ]; then
rolesdir=$1
else
rolesdir=$(dirname $0)/..
fi

[ ! -d $rolesdir/juju4.redhat_epel ] && git clone https://github.com/juju4/ansible-redhat-epel $rolesdir/juju4.redhat_epel
[ ! -d $rolesdir/juju4.rekall ] && git clone https://github.com/juju4/ansible-rekall $rolesdir/juju4.rekall
[ ! -d $rolesdir/geerlingguy.mysql ] && git clone https://github.com/geerlingguy/ansible-role-mysql $rolesdir/geerlingguy.mysql
## galaxy naming: kitchen fails to transfer symlink folder
#[ ! -e $rolesdir/juju4.grr ] && ln -s ansible-grr $rolesdir/juju4.grr
[ ! -e $rolesdir/juju4.grr ] && cp -R $rolesdir/ansible-grr $rolesdir/juju4.grr

## don't stop build on this script return code
true
