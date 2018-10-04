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
- edgedb-jdbc? (maybe on top of [agensgraph-jdbc](https://github.com/bitnine-oss/agensgraph-jdbc))
  - pgsql wire protocol v3 not supported ([see here](https://github.com/edgedb/edgedb/issues/236))
- fdw: oracle, db2, sqlserver, hadoop, cassandra, hive, ...

External tools
- GUI:
  - [OmniDB](https://www.2ndquadrant.com/en/resources/omnidb/) ([docker](https://hub.docker.com/r/wiremind/omnidb/))
  - [pgAdmin4](https://www.pgadmin.org/) ([docker](https://hub.docker.com/r/dpage/pgadmin4/))
  - [AgensBrowser](http://bitnine.net/documentations/agensbrowser-manual-1.0-en.html) ([docker](https://hub.docker.com/r/bitnine/agensbrowser/))
- Monitor/Stats:
  - [pgcluu](http://pgcluu.darold.net/) ([docker](https://hub.docker.com/r/darold/pgcluu/))
  - [pgmonitor](https://github.com/CrunchyData/pgmonitor) ([docker](https://hub.docker.com/r/theborakompanioni/pgmonitor/))
  - [pgwatch2](https://www.cybertec-postgresql.com/en/next-feature-release-for-the-pgwatch2-monitoring-tool/) ([docker](https://hub.docker.com/r/cybertec/pgwatch2-nonroot/))
- Backup:
  - [pgbarman](https://www.pgbarman.org/) ([docker](https://hub.docker.com/r/centerforopenscience/barman/))
- BI:
  - [2UDA](https://www.2ndquadrant.com/en/resources/2uda/)
  - [Orange](https://orange.biolab.si/)
  - [RStudio](https://www.rstudio.com/)([docker](https://hub.docker.com/r/rocker/rstudio/))
- AI/NN/NLP with GPU/CUDA:
  - [PyTorch](https://github.com/pytorch/pytorch)
  - [AllenNLP](https://allennlp.org/)
  - [FastAI](http://www.fast.ai/)
- Fuzzy/Full-Text:
  - [ElasticSearch](https://www.elastic.co/) ([docker](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)/[bitnami](https://hub.docker.com/r/bitnami/elasticsearch/))
