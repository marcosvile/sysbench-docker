# sysbench on Docker
Sysbench 1.0.20-r1 in Docker environment for performance and stress test in mysqlq database. You can use this environment for testing on local databases or cloud instances.

## Example Usage
### Requirement
Create a MySQL database and user for sysbench:

mysql> CREATE SCHEMA sbtest;
mysql> CREATE USER sbtest@'%' IDENTIFIED BY 'password';
mysql> GRANT ALL PRIVILEGES ON sbtest.* to sbtest@'%';
Or simply use the respective MySQL's image environment variables to create the database and user when running the MySQL container.

## Docker
Prepare the sysbench database:

## PREPARE
docker run \
--rm=true \
--name=sb-prepare \
marcosvile/sysbench \
sysbench \
--tables=10 \
--table-size=1000000 \
--mysql-host=dbhostname \
--mysql-port=3306 \
--mysql-user=dbuser  \
--mysql-password='password' \
--mysql-db=database \
/usr/share/sysbench/oltp_read_only.lua \
prepare

In this staging example, we set to staging 10 tables with 1000000 rows, which makes a total dataset of 2.4GB. We pass the bank connection and authentication information.

## TESTNG
docker run \
--rm=true \
--name=sb-teste \
marcosvile/sysbench \
sysbench \
--report-interval=1 \
--tables=10 \
--table-size=1000000 \
--range_selects=off \
--db-ps-mode=disable \
--threads=1000 \
--events=0 \
--time=120 \
--db-driver=mysql \
--mysql-host=dbhostname \
--mysql-port=3306 \
--mysql-user=dbuser \
--mysql-password='password' \
--mysql-db=database \
/usr/share/sysbench/oltp_read_only.lua \
run

In this test example, we are doing a reading action on the tables prepared earlier, with the number of --threads=1000 as a thousand simultaneous readings, the --events=0 means that there is no limit on the number of readings while the test lasts, being that the --time=120 parameter defines that the test duration time is 120s.

## CLEAN UP
docker run \
--rm=true \
--name=sb-cleanup \
marcosvile/sysbench \
sysbench \
--tables=10 \
--table-size=1000000 \
--mysql-host=dbhostname \
--mysql-port=3306 \
--mysql-user=dbuser  \
--mysql-password='password' \
--mysql-db=database \
/usr/share/sysbench/oltp_read_only.lua \
cleanup

In this example we clean up the environment that was created, freeing up the space used for testing.

## To user help of sysbench

docker run \
--rm=true \
--name=sb-cleanup \
marcosvile/sysbench \