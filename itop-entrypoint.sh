#!/bin/bash
set -e

if [ "$1" = 'itop' ]; then

	#if [ -z "$(ls -A "$PGDATA")" ]; then
	#fi
	
	exec /usr/sbin/apachectl -f /etc/apache2/apache2.conf -e info -DFOREGROUND
fi

exec "$@"
