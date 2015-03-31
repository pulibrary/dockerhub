#/bin/bash -ex

: ${HOSTNAME:?"HOSTNAME needs to be set and non-empty"}

if [ -z "$S3_BACKUP" ]
then
	echo "Starting Zookeeper - Exhibitor without S3 Backup"

cat <<- EOF > /usr/lib/exhibitor/defaults.conf
	zookeeper-data-directory=/usr/lib/zookeeper-3.4.6/zookeeper-data
	zookeeper-install-directory=/usr/lib/zookeeper-3.4.6
	zookeeper-log-directory=/usr/lib/zookeeper-3.4.6/zookeeper-logs
	log-index-directory=/usr/lib/zookeeper-3.4.6/zookeeper-logs
	cleanup-period-ms=300000
	check-ms=30000
	backup-period-ms=600000
	client-port=2181
	cleanup-max-files=20
	backup-max-store-ms=21600000
	connect-port=2888
	observer-threshold=0
	election-port=3888
	zoo-cfg-extra=tickTime\=2000&initLimit\=10&syncLimit\=5&quorumListenOnAllIPs\=true
	auto-manage-instances-settling-period-ms=0
	auto-manage-instances=1
	log4j-properties=log4j.rootLogger\=INFO, file\nlog4j.appender.file\=org.apache.log4j.FileAppender\nlog4j.appender.file.File\=/usr/lib/zookeeper-3.4.6/zookeeper.log\nlog4j.appender.file.layout\=org.apache.log4j.PatternLayout\nlog4j.appender.file.layout.conversionPattern\=%d %-5p: %c - %m%n
EOF

	exec 2>&1

	java -jar /usr/lib/exhibitor/exhibitor.jar \
	--port 8383 --defaultconfig /usr/lib/exhibitor/defaults.conf --configtype file --hostname ${HOSTNAME}

else
	echo "Starting Zookeeper - Exhibitor with S3 Backup"

	: ${S3_BUCKET:?"S3_BUCKET needs to be set and non-empty"}
	: ${S3_PREFIX:?"S3_PREFIX needs to be set and non-empty"}
	: ${AWS_ACCESS_KEY_ID:?"AWS_ACCESS_KEY_ID needs to be set and non-empty"}
	: ${AWS_SECRET_ACCESS_KEY:?"AWS_SECRET_ACCESS_KEY needs to be set and non-empty"}
	: ${AWS_REGION:="us-west-2"}

cat <<- EOF > /usr/lib/exhibitor/credentials.properties
	com.netflix.exhibitor.s3.access-key-id=${AWS_ACCESS_KEY_ID}
	com.netflix.exhibitor.s3.access-secret-key=${AWS_SECRET_ACCESS_KEY}
EOF

cat <<- EOF > /usr/lib/exhibitor/defaults.conf
	zookeeper-data-directory=/usr/lib/zookeeper-3.4.6/zookeeper-data
	zookeeper-install-directory=/usr/lib/zookeeper-3.4.6
	zookeeper-log-directory=/usr/lib/zookeeper-3.4.6/zookeeper-logs
	log-index-directory=/usr/lib/zookeeper-3.4.6/zookeeper-logs
	cleanup-period-ms=300000
	check-ms=30000
	backup-period-ms=600000
	client-port=2181
	cleanup-max-files=20
	backup-max-store-ms=21600000
	connect-port=2888
	backup-extra=throttle\=&bucket-name\=${S3_BUCKET}&key-prefix\=${S3_PREFIX}&max-retries\=4&retry-sleep-ms\=30000
	observer-threshold=0
	election-port=3888
	zoo-cfg-extra=tickTime\=2000&initLimit\=10&syncLimit\=5&quorumListenOnAllIPs\=true
	auto-manage-instances-settling-period-ms=0
	auto-manage-instances=1
	log4j-properties=log4j.rootLogger\=INFO, file\nlog4j.appender.file\=org.apache.log4j.FileAppender\nlog4j.appender.file.File\=/usr/lib/zookeeper-3.4.6/zookeeper.log\nlog4j.appender.file.layout\=org.apache.log4j.PatternLayout\nlog4j.appender.file.layout.conversionPattern\=%d %-5p: %c - %m%n
EOF

	exec 2>&1

	java -jar /usr/lib/exhibitor/exhibitor.jar \
	--port 8383 --defaultconfig /usr/lib/exhibitor/defaults.conf \
	--configtype s3 --s3config ${S3_BUCKET}:${S3_PREFIX} \
	--s3credentials /usr/lib/exhibitor/credentials.properties \
	--s3region ${AWS_REGION} --s3backup true --hostname ${HOSTNAME}

fi