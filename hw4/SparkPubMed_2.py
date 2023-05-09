from __future__ import print_function

import sys
from operator import add

from pyspark.sql import SparkSession

if __name__ == "__main__":

    if len(sys.argv) != 4:
        print("Usage: SparkPubMed_2 <input_file_path> <year> <output_file_path>")
        sys.exit()

    input_file_path = sys.argv[1]
    year = sys.argv[2]
    output_file_path = sys.argv[3]

    spark = SparkSession\
        .builder\
        .appName("PublicationCountSpecificYear")\
        .getOrCreate()

    df = spark.read.option("delimiter", "\t").csv(input_file_path, header=False)

    filtered_df = df.filter(df._c6 == year)

    result_df = filtered_df.groupBy("_c7").count().sort("count", ascending=False)

    result_df.rdd.map(lambda x: "{0}\t{1}".format(x[0], x[1])).saveAsTextFile(output_file_path)

    spark.stop()
