create index cse532.facilitygseidx on cse532.TRIFacility(geolocation) extend using db2gse.spatial_index(0.75, 2, 5);

runstats on table cse532.TRIFACILITY  and indexes all;