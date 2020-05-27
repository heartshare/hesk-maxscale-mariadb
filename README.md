# Hesk with MariaDB + MaxScale as storage backend

This is a playground that demomnstrate how to use [MaxScale] in a LAMP
scenario like the [Hesk] deployment. The MaxScale configuration was
inspired from the example provided with the [official MaxScale Docker image].

## How to run

We assume [Docker] and [Docker Compose] already installed.

1.  Open a shell and execute the following command to deploy the stack

        $ docker-compose up --build

2.  Open another shell and execute the following command to obtain the IP of
    the Hesk instance

        $ docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' hesk

3.  Go to the following URL to start the Hesk installation

        http://<hesk ip>/install

    Use the following parameters for the connection to the database

        DB host: maxscale:4006
        DB name: hesk
        DB user: hesk_user
        DB pass: hesk_pass

    Once installed, the `hesk_dir` will contain the installation files
    (including the `install` directory that must be deleted).

## Play with MaxScale

*  List the servers

        $ docker-compose exec maxscale maxctrl list servers
        ┌────────┬─────────┬──────┬─────────────┬─────────────────┬───────────┐
        │ Server │ Address │ Port │ Connections │ State           │ GTID      │
        ├────────┼─────────┼──────┼─────────────┼─────────────────┼───────────┤
        │ mdb0   │ mdb0    │ 3306 │ 0           │ Master, Running │ 0-3000-19 │
        ├────────┼─────────┼──────┼─────────────┼─────────────────┼───────────┤
        │ mdb1   │ mdb1    │ 3306 │ 0           │ Slave, Running  │ 0-3000-19 │
        ├────────┼─────────┼──────┼─────────────┼─────────────────┼───────────┤
        │ mdb2   │ mdb2    │ 3306 │ 0           │ Slave, Running  │ 0-3000-19 │
        └────────┴─────────┴──────┴─────────────┴─────────────────┴───────────┘

*   Stop the master (`mdb0`)

        $ docker-compose stop mdb0
        Stopping mdb-0 ... done

    and after a while, check again the servers status

        $ docker-compose exec maxscale maxctrl list servers
        ┌────────┬─────────┬──────┬─────────────┬─────────────────┬───────────┐
        │ Server │ Address │ Port │ Connections │ State           │ GTID      │
        ├────────┼─────────┼──────┼─────────────┼─────────────────┼───────────┤
        │ mdb0   │ mdb0    │ 3306 │ 0           │ Down            │ 0-3000-19 │
        ├────────┼─────────┼──────┼─────────────┼─────────────────┼───────────┤
        │ mdb1   │ mdb1    │ 3306 │ 0           │ Master, Running │ 0-3000-19 │
        ├────────┼─────────┼──────┼─────────────┼─────────────────┼───────────┤
        │ mdb2   │ mdb2    │ 3306 │ 0           │ Slave, Running  │ 0-3000-19 │
        └────────┴─────────┴──────┴─────────────┴─────────────────┴───────────┘

*   Restart the old master (`mdb0`)

        $ docker-compose start mdb0
        Starting mdb0 ... done
    
    and after a while, check again the servers status

        $ docker-compose exec maxscale maxctrl list servers
        ┌────────┬─────────┬──────┬─────────────┬─────────────────┬───────────┐
        │ Server │ Address │ Port │ Connections │ State           │ GTID      │
        ├────────┼─────────┼──────┼─────────────┼─────────────────┼───────────┤
        │ mdb0   │ mdb0    │ 3306 │ 0           │ Slave, Running  │ 0-3000-19 │
        ├────────┼─────────┼──────┼─────────────┼─────────────────┼───────────┤
        │ mdb1   │ mdb1    │ 3306 │ 0           │ Master, Running │ 0-3000-19 │
        ├────────┼─────────┼──────┼─────────────┼─────────────────┼───────────┤
        │ mdb2   │ mdb2    │ 3306 │ 0           │ Slave, Running  │ 0-3000-19 │
        └────────┴─────────┴──────┴─────────────┴─────────────────┴───────────┘

## References

* [MaxScale]
* [MariaDB]
* [Hesk]
* [Docker]
* [Docker Compose]


[MaxScale]: https://mariadb.com/kb/en/maxscale
[MariaDB]: https://mariadb.com/kb/en/documentation
[Hesk]: https://www.hesk.com
[Docker]: https://docs.docker.com/get-docker
[Docker Compose]: https://docs.docker.com/compose/install
[official MaxScale Docker image]: https://github.com/mariadb-corporation/maxscale-docker/tree/master/maxscale
