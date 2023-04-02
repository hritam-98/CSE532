create index cse532.zipidx on cse532.zcta(shape) extend using db2gse.spatial_index(.25, 1.0, 2);

runstats on table cse532.zcta and indexes all;