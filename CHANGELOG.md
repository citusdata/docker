### citus-docker v8.3.0.docker (July 10, 2019) ###

* Bump Citus version to 8.3.0

* Bump PostgreSQL version to 11.4

### citus-docker v8.2.2.docker (June 12, 2019) ###

* Bump Citus version to 8.2.2

### citus-docker v8.2.1.docker (April 4, 2019) ###

* Bump Citus version to 8.2.1

### citus-docker v8.2.0.docker (March 29, 2019) ###

* Bump Citus version to 8.2.0

### citus-docker v8.1.1.docker (January 7, 2019) ###

* Bump Citus version to 8.1.1

### citus-docker v8.1.0.docker (December 18, 2018) ###

* Bump Citus version to 8.1.0

### citus-docker v8.0.2.docker (December 13, 2018) ###

* Bump Citus version to 8.0.2

### citus-docker v8.0.0-1.docker (November 05, 2018) ###

* Bump Citus version to 8.0.0-1

* Update postgresql-hll packages

### citus-docker v8.0.0.docker (November 02, 2018) ###

* Bump Citus version to 8.0.0

* Bump PostgreSQL version to 11

### citus-docker v7.5.1.docker (August 29, 2018) ###

* Bump Citus version to 7.5.1

### citus-docker v7.5.0.docker (July 25, 2018) ###

* Bump Citus version to 7.5.0

* Bump PostgreSQL version to 10.4

### citus-docker v7.4.1.docker (June 20, 2018) ###

* Bump Citus version to 7.4.1

### citus-docker v7.4.0-2.docker (Jun 1, 2018) ###

* Add postgresql-topn to docker image

* Bump Citus version to 7.4.0-2

### citus-docker v7.4.0-1.docker (Jun 1, 2018) ###

* Add postgresql-hll to docker image

* Bump Citus version to 7.4.0-1

### citus-docker v7.4.0.docker (May 15, 2018) ###

* Bump Citus version to 7.4.0

### citus-docker v7.3.0.docker (March 15, 2018) ###

* Bump Citus version to 7.3.0

* Bump PostgreSQL version to 10.3

### citus-docker v7.2.1.docker (February 6, 2018) ###

* Bump Citus version to 7.2.1

### citus-docker v7.2.0.docker (January 17, 2018) ###

* Bump Citus version to 7.2.0

### citus-docker v7.1.2.docker (January 8, 2018) ###

* Bump Citus version to 7.1.2

### citus-docker v7.1.1-1.docker (December 5, 2017) ###

* Bump Citus version to 7.1.1

### citus-docker v7.1.0-1.docker (November 15, 2017) ###

* Based on latest PostgreSQL 10.1 images and official Citus 7.1.0 package

* Underlying PostgreSQL image now based on Debian Stretch (was Jessie)

* Stats collection identifies host as Docker-based

### citus-docker v7.1.0 (November 15, 2017) ###

* Bump Citus version to 7.1.0

* Anonymous stats collection can be disabled by setting the `DISABLE_STATS_COLLECTION` environment variable to any value when starting a Citus container

### citus-docker v7.0.3 (October 18, 2017) ###

* Bump Citus version to 7.0.3

### citus-docker v7.0.2 (October 2, 2017) ###

* Bump Citus version to 7.0.2

* Bump membership manager to 0.2.0

### citus-docker v7.0.1-1.docker (September 15, 2017) ###

* Adds Alpine Linux variants of our stable image

### citus-docker v7.0.1 (September 12, 2017) ###

* Bump Citus version to 7.0.1

* Based on latest PostgreSQL 9.6.5 image and official Citus 7.0.1 package

### citus-docker v7.0.0 (Aug 29, 2017) ###

* Bump Citus version to 7.0.0

* Based on latest PostgreSQL 9.6.4 image and official Citus 7.0.0 package

### citus-docker v6.2.3 (Jul 14, 2017) ###

* Bump Citus version to 6.2.3

### citus-docker v6.2.2 (Jun 6, 2017) ###

* Bump Citus version to 6.2.2

### citus-docker v6.2.1 (May 24, 2017) ###

* Bump Citus version to 6.2.1

### citus-docker v6.1.1 (May 16, 2017) ###

* Bump Citus version to 6.1.1

* Based on latest PostgreSQL 9.6.3 image and official Citus 6.1.1 package

### citus-docker v6.1.0 (February 10, 2017) ###

* Bump Citus version to 6.1.0

* Based on latest PostgreSQL 9.6.2 image and official Citus 6.1.0 package

* Fixes to address breakage from recent postgres image changes

### citus-docker v6.0.1 (December 1, 2016) ###

* Bump Citus version to 6.0.1

### citus-docker v6.0.0 (November 9, 2016) ###

* Bump Citus version to 6.0.0

* Based on latest PostgreSQL 9.6.1 image and official Citus 6.0.0 package

### citus-docker v5.2.2 (November 8, 2016) ###

* Bump Citus version to 5.2.2

* Based on latest PostgreSQL 9.5.5 image and official Citus 5.2.2 package

### citus-docker v5.2.1-1.docker (September 16, 2016) ###

* Preserves ca-certificates package in images to avoid breaking apt-get

* Ensures removal of community GPG key in nightly image build

### citus-docker v5.2.1 (September 6, 2016) ###

* Bump Citus version to 5.2.1; fixes a subquery bug

* Based on latest PostgreSQL 9.5.4 image and official Citus 5.2.1 package

### citus-docker v5.2.0 (August 17, 2016) ###

* Bump Citus version to 5.2.0; brings schemas, SERIAL, RETURNING, transactions

* Based on latest PostgreSQL 9.5.4 image and official Citus 5.2.0 package

### citus-docker v5.1.1 (July 7, 2016) ###

* This image now uses repos.citusdata.com (offical Citus package repo)

* Bump Citus version to 5.1.1; improves task tracker and count distinct

* Based on latest PostgreSQL 9.5.3 image and official Citus 5.1.1 package

### citus-docker v5.1.0 (May 17, 2016) ###

* Bump Citus version to 5.1.0; brings COPY, EXPLAIN, and more performance

* Based on latest PostgreSQL 9.5.3 image and official Citus 5.1.0 package

### citus-docker v5.0.1 (March 24, 2016) ###

* Install package from PGDG!

* Based on latest PostgreSQL 9.5.2 image and official Citus 5.0.1 package

### citus-docker v5.0.0 (March 24, 2016) ###

* Initial public release

* Based on latest PostgreSQL 9.5.1 image and official Citus 5.0.0 package

### citus-docker v0.9.1 (March 14, 2016) ###

* Simplifies startup process using new postgresql.conf.sample feature

* Based on latest PostgreSQL 9.5.1 image and official Citus 5.0.0-rc.3 package

### citus-docker v0.9.0 (March 2, 2016) ###

* Initial release

* Provides standard Docker image for Citus

* Includes example Docker Compose and Docker Cloud configuration

* Based on PostgreSQL 9.5.1 and Citus 5.0.0-rc.2
