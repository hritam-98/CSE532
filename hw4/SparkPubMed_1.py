from __future__ import print_function

import sys
from operator import add

from pyspark.sql import SparkSession


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: SparkPubMed_1.py <input file path> <output file path>", file=sys.stderr)
        sys.exit(-1)

    spark = SparkSession\
        .builder\
        .appName("PublicationCountPerYear")\
        .getOrCreate()



    lines = spark.read.text(sys.argv[1]).rdd.map(lambda r: r[0])

    # Map each line to a tuple of (year, 1)
    years = lines.map(lambda line: line.split("\t")).map(lambda words: (words[6], 1))

    # Reduce by key to get the count for each year
    count_per_year = years.reduceByKey(lambda x, y: x + y)

    # Save the results to the output path
    count_per_year.map(lambda x: "%s\t%s" % (x[0], x[1])).saveAsTextFile(sys.argv[2])   

    

    spark.stop()