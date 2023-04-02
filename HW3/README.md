HW-3: Bonus work
----------------

Following is the summary of query 1 and query 2 with 3 index setting:

A) First, I run both of them with the following indexes:

CREATE INDEX cse532.facilitygseidx ON cse532.TRIFacility(geolocation) extend USING db2gse.spatial_index(0.75, 2, 5);

CREATE INDEX cse532.zipidx ON cse532.zcta(shape) extend USING db2gse.spatial_index(0.25, 1.0, 2);

I maintained the same recommended setting from the course website for grid size. For this, query 1 and query 2 ran for around 26s 542ms and 533ms, respectively.

B) Then, Index Advisor is used to find the grid size for the index intended, and the gridsize for TRIFacility table's geolocation is (0.02, 0, 0) and zcta table's shape is (0.32, 0.96, 3.8). Both the queries are run using the following indexes:

CREATE INDEX cse532.facilitygseidx ON cse532.TRIFacility(geolocation) extend USING db2gse.spatial_index(0.02, 0, 0);

CREATE INDEX cse532.zipidx ON cse532.zcta(shape) extend USING db2gse.spatial_index(0.32, 0.96, 3.8);

For this, query 1 and query 2 ran for around 26s 861ms and 845ms, respectively.

C) At last, all the indexes are deleted for running both the queries. Now, query 1 and query 2 took around 29s 443ms and 912ms, respectively.
