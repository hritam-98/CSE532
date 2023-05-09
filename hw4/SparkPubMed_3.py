from __future__ import print_function

import sys
from operator import add

from pyspark.sql import SparkSession

def extract_author(line):
    fields = line.split('\t')
    return fields[6], fields[2]

if __name__ == "__main__":

    if len(sys.argv) != 3:
        print("Usage: SparkPubMed_3 <input_file_path> <output_file_path>")
        sys.exit()

    input_file_path = sys.argv[1]
    output_file_path = sys.argv[2]

    spark = SparkSession\
        .builder\
        .appName("TopAuthorPerYear")\
        .getOrCreate()

    # read the dataset
    data = spark.read.text(input_file_path).rdd.map(lambda r: r[0])

    # filter data for Australia and USA
    data = data.filter(lambda line: "Australia" in line or "USA" in line)

    # extract year, author and count
    year_author = data.map(extract_author)\
                      .map(lambda x: ((x[0], x[1]), 1))\
                      .reduceByKey(lambda x, y: x + y)

    # group data by year
    by_year = year_author.map(lambda x: (x[0][0], (x[0][1], x[1])))\
                         .groupByKey()

    # get top 3 authors by count for Australia and USA for each year
    top_authors = by_year.mapValues(lambda x: sorted(x, key=lambda y: y[1], reverse=True))\
                         .mapValues(lambda x: [(y[0], y[1]) for y in x[:3]] + 
                                               [(y[0], y[1]) for y in x[3:] if y[1] == x[2][1]])

    # write output to file
    top_authors.map(lambda x: str(x[0]) + '\t' + ';'.join([y[0] + ',' + str(y[1]) for y in x[1]]))\
               .saveAsTextFile(output_file_path)

    sc.stop()


