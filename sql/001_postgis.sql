-- yum install postgis2_94 postgresql94-contrib
-- Enable PostGIS
CREATE EXTENSION postgis;
-- Enable Topology
CREATE EXTENSION postgis_topology;
-- Enable fuzzy match
CREATE EXTENSION fuzzystrmatch;
-- Enable Tiger Geocoder
CREATE EXTENSION postgis_tiger_geocoder;
commit;
