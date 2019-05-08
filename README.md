sv2
===

Experimenting with [EdgeDB](https://edgedb.com/) on top of [AgensGraph](https://bitnine.net/agensgraph/) + extensions included in contrib and:
- [TimescaleDB](https://www.timescale.com/)
- [Citusdata](https://www.citusdata.com/)
- [ZomboDB](https://www.zombodb.com/)
- [PostGIS](https://postgis.net/)
- [acl](https://pgxn.org/dist/acl/acl.html)
- icu
- pam
- ldap
- gssapi
- kerberos
- [pg_cron](https://github.com/citusdata/pg_cron)
- [plr](https://github.com/postgres-plr/plr.git)
- [plv8](https://plv8.github.io/)
- pltcl
- [pllua](https://github.com/pllua/pllua-ng)
- plperl
- plpython
  - fdw: [multicorn+sqlalchemy-fdw](https://multicorn.org/sqlalchemy-fdw/)
  - machine learning / data analysis / deep learning: [scikit-learn](http://scikit-learn.org), [tensorflow](https://www.tensorflow.org), [pandas](https://pandas.pydata.org), [keras](https://keras.io)
- [pgcenter](https://github.com/lesovsky/pgcenter)
- pgtop

TODO
- [PipelineDB 1.0.0](https://github.com/pipelinedb/pipelinedb)
- [HyperLogLog](https://github.com/citusdata/postgresql-hll)
- [pg_permission](https://github.com/cybertec-postgresql/pg_permission)
- [pg_prewarm](https://www.postgresql.org/docs/current/pgprewarm.html)
- [AdaNet](https://github.com/tensorflow/adanet)
- edgedb-jdbc? (maybe on top of [agensgraph-jdbc](https://github.com/bitnine-oss/agensgraph-jdbc))
  - pgsql wire protocol v3 not supported ([see here](https://github.com/edgedb/edgedb/issues/236))
- [fdw](https://wiki.postgresql.org/wiki/Foreign_data_wrappers): oracle, db2, [sqlserver](https://fluca1978.github.io/2019/01/18/PostgreSQL-TDS-FDW.html), hadoop, cassandra, hive, ...

External tools
- GUI:
  - [OmniDB](https://www.2ndquadrant.com/en/resources/omnidb/) ([docker](https://hub.docker.com/r/wiremind/omnidb/))
  - [pgAdmin4](https://www.pgadmin.org/) ([docker](https://hub.docker.com/r/dpage/pgadmin4/))
  - [AgensBrowser](http://bitnine.net/documentations/agensbrowser-manual-1.0-en.html) ([docker](https://hub.docker.com/r/bitnine/agensbrowser/))
- Monitor/Stats:
  - [pgcluu](http://pgcluu.darold.net/) ([docker](https://hub.docker.com/r/darold/pgcluu/))
  - [pgmonitor](https://github.com/CrunchyData/pgmonitor) ([docker](https://hub.docker.com/r/theborakompanioni/pgmonitor/))
  - [pgwatch2](https://www.cybertec-postgresql.com/en/next-feature-release-for-the-pgwatch2-monitoring-tool/) ([docker](https://hub.docker.com/r/cybertec/pgwatch2-nonroot/))
  - [pgmetrics](https://pgmetrics.io/) ([docker](https://hub.docker.com/r/rapidloop/pgmetrics/))
- Backup:
  - [pgbarman](https://www.pgbarman.org/) ([docker](https://hub.docker.com/r/centerforopenscience/barman/))
  - [pgBackRest](https://pgbackrest.org/)
- BI:
  - [2UDA](https://www.2ndquadrant.com/en/resources/2uda/)
  - [Orange](https://orange.biolab.si/)
  - [RStudio](https://www.rstudio.com/) ([docker](https://hub.docker.com/r/rocker/rstudio/))
- AI/NN/NLP with GPU/CUDA:
  - [PyTorch](https://github.com/pytorch/pytorch)
  - [AllenNLP](https://allennlp.org/)
  - [FastAI](http://www.fast.ai/)
- Fuzzy/Full-Text:
  - [ElasticSearch](https://www.elastic.co/) ([docker](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)/[bitnami](https://hub.docker.com/r/bitnami/elasticsearch/)/[opendistro](https://hub.docker.com/r/amazon/opendistro-for-elasticsearch))
- GraphQL:
  - [Hasura](https://hasura.io/) ([docker](https://docs.hasura.io/1.0/graphql/manual/getting-started/docker-simple.html))
  - [PostGraphile](https://github.com/graphile/postgraphile) ([docker](https://github.com/graphile/postgraphile#docker))
- HA:
  - [PostDock](https://github.com/paunin/PostDock)
    ([watchdog](https://github.com/yucigou/PostDock/tree/watchdog))
  - [Stolon](https://github.com/sorintlab/stolon)
  - [repmgr](https://repmgr.org/)
  - [pg_auto_failover](https://cloudblogs.microsoft.com/opensource/2019/05/06/introducing-pg_auto_failover-postgresql-open-source-extension-automated-failover-high-availability/)
- ETL:
  - [pgloader](https://pgloader.io/) ([docker](https://hub.docker.com/r/dimitri/pgloader/))
  - [Hindsight](https://github.com/mozilla-services/hindsight) ([docker](https://hub.docker.com/r/mozilla/lua_sandbox_extensions/))
