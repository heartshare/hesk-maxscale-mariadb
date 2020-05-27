RESET MASTER;

SET GLOBAL max_connections=1000;
SET GLOBAL gtid_strict_mode=ON;

--
-- setup monitor user (monitoruser, monitorpw)
--
CREATE USER 'monitor_user'@'127.0.0.1' IDENTIFIED BY 'm0ns3cr3t';
CREATE USER 'monitor_user'@'%' IDENTIFIED BY 'm0ns3cr3t';

GRANT
    EVENT,
    PROCESS,
    RELOAD,
    REPLICATION CLIENT,
    SHOW DATABASES,
    SUPER
ON *.*
TO 'monitor_user'@'127.0.0.1';

GRANT
    EVENT,
    PROCESS,
    RELOAD,
    REPLICATION CLIENT,
    SHOW DATABASES,
    SUPER
ON *.*
TO 'monitor_user'@'%';

--
-- setup replication user (replication_user, replication_password)
--
CREATE USER 'repl_user'@'127.0.0.1' IDENTIFIED BY 'r3ps3cr3t';
CREATE USER 'repl_user'@'%' IDENTIFIED BY 'r3ps3cr3t';

GRANT
    REPLICATION SLAVE
ON *.*
TO 'repl_user'@'127.0.0.1';

GRANT
    REPLICATION SLAVE
ON *.*
TO 'repl_user'@'%';

--
-- setup service user
--
CREATE USER 'srv_user'@'127.0.0.1' IDENTIFIED BY '5rvs3cr3t';
CREATE USER 'srv_user'@'%' IDENTIFIED BY '5rvs3cr3t';

GRANT SELECT
ON mysql.*
TO 'srv_user'@'127.0.0.1';

GRANT SHOW DATABASES
ON *.*
TO 'srv_user'@'127.0.0.1';

GRANT SELECT
ON mysql.*
TO 'srv_user'@'%';

GRANT SHOW DATABASES
ON *.*
TO 'srv_user'@'%';

--
-- init hesk database
--
CREATE DATABASE hesk;
CREATE USER 'hesk_user'@'127.0.0.1' IDENTIFIED BY 'hesk_pass';
CREATE USER 'hesk_user'@'%' IDENTIFIED BY 'hesk_pass';
GRANT ALL ON hesk.* TO 'hesk_user'@'127.0.0.1';
GRANT ALL ON hesk.* TO 'hesk_user'@'%';
