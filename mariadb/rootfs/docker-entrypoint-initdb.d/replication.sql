RESET MASTER;

SET GLOBAL max_connections=1000;
SET GLOBAL gtid_strict_mode=ON;

CHANGE MASTER TO
    MASTER_HOST='mdb-0',
    MASTER_PORT=3306,
    MASTER_USER='repl_user',
    MASTER_PASSWORD='r3ps3cr3t',
    MASTER_USE_GTID=slave_pos;

START SLAVE;
