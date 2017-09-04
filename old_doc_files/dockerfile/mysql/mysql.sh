#!/bin/bash

###
### MySQL Password Options
###
export MYSQL_ROOT_PASSWORD=111111



	# Wait at max 60 seconds for it to start up
	i=0
	max=60
	while [ $i -lt $max ]; do
		if echo 'SELECT 1' |  mysql --protocol=socket -uroot  > /dev/null 2>&1; then
			break
		fi
		log "info" "Initializing ..."
		sleep 1s
		i=$(( i + 1 ))
	done


	# Get current pid
	pid="$(pgrep mysqld | head -1)"
	if [ "${pid}" = "" ]; then
		log "err" "Could not find running MySQL PID."
		log "err" "MySQL init process failed."
		exit 1
	fi


	# Bootstrap MySQL
	log "info" "Setting up root user permissions."
	echo "DELETE FROM mysql.user ;" | mysql --protocol=socket -uroot
	echo "CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;" | mysql --protocol=socket -uroot
	echo "GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;" | mysql --protocol=socket -uroot
	echo "DROP DATABASE IF EXISTS test ;" | mysql --protocol=socket -uroot
	echo "FLUSH PRIVILEGES ;" | mysql --protocol=socket -uroot


	# Shutdown MySQL
	log "info" "Shutting down MySQL."
	run "kill -s TERM ${pid}"
	i=0
	max=60
	while [ $i -lt $max ]; do
		if ! pgrep mysqld >/dev/null 2>&1; then
			break
		fi
		sleep 1s
		i=$(( i + 1 ))
	done


	# Check if it is still running
	if pgrep mysqld >/dev/null 2>&1; then
		log "err" "Unable to shutdown MySQL server."
		log "err" "MySQL init process failed."
		exit 1
	fi
	log "info" "MySQL successfully installed."





###
### Start
###
log "info" "Starting $(mysqld --version)"
mysqld
