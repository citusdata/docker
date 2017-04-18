# Citus

[![Image Size](https://img.shields.io/imagelayers/image-size/citusdata/citus/latest.svg)][image size]
[![Release](https://img.shields.io/github/release/citusdata/docker.svg)][release]
[![License](https://img.shields.io/github/license/citusdata/docker.svg)][license]

Citus is a PostgreSQL-based distributed RDBMS. For more information, see the [Citus Data website][citus data].

## Function

This image provides a single running Citus instance (atop PostgreSQL 9.6), using standard configuration values. It is based on [the official PostgreSQL image][docker-postgres], so be sure to consult that image’s documentation for advanced configuration options (including non-default settings for e.g. `PGDATA` or `POSTGRES_USER`).

Just like the standard PostgreSQL image, this image exposes port `5432`. In other words, all containers on the same Docker network should be able to connect on this port, and exposing it externally will permit connections from external clients (`psql`, adapters, applications).

## Usage

Since Citus is intended for use within a cluster, there are many ways to deploy it. This repository provides configuration to permit three kinds of deployment: local (standalone), local (with workers), and cloud-based (with workers).

### Standalone Use

If you just want to run a single Citus instance, it’s pretty easy to get started:

```bash
docker run --name citus_standalone -p 5432:5432 citusdata/citus
```

If you’re using `docker-machine`, you might want to run `docker-machine ip` to determine the host to connect to. Otherwise, you should be able to connect to `127.0.0.1` on port `5432` using e.g. `psql` to run a few commands (see the Citus documentation for more information).

As with the PostgreSQL image, the default `PGDATA` directory will be mounted as a volume, so it will persist between restarts of the container. But while the above _will_ get you a running Citus instance, it won’t have any workers to exercise distributed query planning. For that, you may wish to try the included [`docker-compose.yml`][compose-config] configuration.

#### Nightly Image

In addition to the `latest` (release) tag and the major-, minor-, and patch-specific tags, the `Dockerfile` in the `nightly` directory builds a tagged image with the latest Citus nightly (from the Citus `master` branch).

### Docker Compose

The included `docker-compose.yml` file provides an easy way to get started with a Citus cluster, complete with multiple workers. Just copy it to your current directory and run:

```bash
docker-compose -p citus up

# Creating network "citus_default" with the default driver
# Creating citus_worker_1
# Creating citus_master
# Creating citus_config
# Attaching to citus_worker_1, citus_master, citus_config
# worker_1    | The files belonging to this database system will be owned by user "postgres".
# worker_1    | This user must also own the server process.
# ...
```

That’s it! As with the standalone mode, you’ll want to find your `docker-machine ip` if you’re using that technology, otherwise, just connect locally to `5432`. By default, you’ll only have one worker:

```sql
SELECT master_get_active_worker_nodes();

--  master_get_active_worker_nodes
-- --------------------------------
--  (citus_worker_1,5432)
-- (1 row)
```

But you can add more workers at will using `docker-compose scale` in another tab. For instance, to bring your worker count to five…

```bash
docker-compose -p citus scale worker=5

# Creating and starting 2 ... done
# Creating and starting 3 ... done
# Creating and starting 4 ... done
# Creating and starting 5 ... done
```

```sql
SELECT master_get_active_worker_nodes();

--  master_get_active_worker_nodes
-- --------------------------------
--  (citus_worker_5,5432)
--  (citus_worker_1,5432)
--  (citus_worker_3,5432)
--  (citus_worker_2,5432)
--  (citus_worker_4,5432)
-- (5 rows)
```

If you inspect the configuration file, you’ll find that there is a container that is neither a master nor worker node: `citus_config`. It simply listens for new containers tagged with the worker role, then adds them to the config file in a volume shared with the master node. If new nodes have appeared, it calls `master_initialize_node_metadata` against the master to repopulate the node table. See Citus’ [`workerlist-gen`][workerlist-gen] repo for more details.

You can stop your cluster with `docker-compose -p citus down`.

### Docker Cloud

Now the real fun starts!

As the Docker Cloud UI is mostly self-explanatory, we’ll cover getting a Citus cluster running via the `docker-cloud` CLI. First, we’ll need some node clusters. The master cluster will have one node and the worker cluster will have two:

```bash
docker-cloud nodecluster create --tag master citus_master_node digitalocean nyc1 2gb
docker-cloud nodecluster create --tag worker -t2 citus_worker_nodes digitalocean nyc1 1gb
```

Surprisingly, this is all the setup needed to deploy our stack. All that’s left is to start it. Ensure the `tutum.yml` file is in the current directory, then run:

```bash
docker-cloud stack up -n citus-cloud
```

After the stack has started, we can view its endpoints:

```bash
docker-cloud service ps --stack citus-cloud
# NAME    UUID      STATUS       #CONTAINERS  IMAGE                                        DEPLOYED       PUBLIC DNS                                    STACK
# worker  example  ▶ Running              2  citusdata/citus:latest                       2 minutes ago  worker.citus-cloud.examples.svc.dockerapp.io  citus-cloud
# master  example  ▶ Running              1  citusdata/citus:latest                       2 minutes ago  master.citus-cloud.examples.svc.dockerapp.io  citus-cloud
# config  example  ▶ Running              1  citusdata/dockercloud-workerlist-gen:latest  1 minute ago   config.citus-cloud.examples.svc.dockerapp.io  citus-cloud
```

The master node should be reachable at its public address on port `5432`. One last thing… as with Compose, you can even scale your worker service to add more containers: `docker-cloud service scale worker.citus-cloud 5`. They’ll show up in the master’s worker list file as soon as they’re available (this functionality provided by [`dockercloud-workerlist-gen`][dockercloud-workerlist-gen]).

You can stop your stack with `docker-cloud stack terminate citus-cloud`.

## License

The following license information (and associated [LICENSE][license] file) apply _only to the files within **this** repository_. Please consult Citus’s own repository for information regarding its licensing.

Copyright © 2016–2017 Citus Data, Inc.

Licensed under the Apache License, Version 2.0 (the “License”); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

[image size]: https://imagelayers.io/?images=citusdata%2Fcitus:latest
[release]: https://github.com/citusdata/docker/releases/latest
[license]: LICENSE
[citus data]: https://www.citusdata.com
[docker-postgres]: https://hub.docker.com/_/postgres/
[compose-config]: docker-compose.yml
[workerlist-gen]: https://github.com/citusdata/workerlist-gen
[dockercloud-workerlist-gen]: https://github.com/citusdata/dockercloud-workerlist-gen
