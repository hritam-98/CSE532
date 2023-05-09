package org.hbasak;

import java.io.IOException;
import java.util.*;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.conf.*;
import org.apache.hadoop.io.*;
import org.apache.hadoop.mapreduce.*;
import org.apache.hadoop.mapreduce.lib.input.*;
import org.apache.hadoop.mapreduce.lib.output.*;
import org.apache.hadoop.util.*;

public class PubMed_3 extends Configured implements Tool {

    public static class Map extends Mapper<LongWritable, Text, Text, IntWritable> {

        private Text journal = new Text();
        private final static IntWritable one = new IntWritable(1);
        private int year_of_interest;

        @Override
        public void setup(Context context) {
            Configuration conf = context.getConfiguration();
            year_of_interest = Integer.parseInt(conf.get("year_of_interest"));
        }

        @Override
        public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {

            String[] result = value.toString().split("\t");

            int year = Integer.parseInt(result[6]);

            if (year != year_of_interest) {
                return;
            }

            journal.set(result[7]);
            context.write(journal, one);
        }
    }

    public static class Reduce extends Reducer<Text, IntWritable, Text, IntWritable> {

        @Override
        public void reduce(Text key, Iterable<IntWritable> values, Context context) throws IOException, InterruptedException {

            int sum = 0;

            for (IntWritable value : values) {
                sum += value.get();
            }

            context.write(key, new IntWritable(sum));
        }
    }

    public int run(String[] args) throws Exception {

        if (args.length != 3) {
            System.err.println("Usage: PubMed_3 <input path> <year of interest> <output path>");
            return -1;
        }

        int year_of_interest = Integer.parseInt(args[1]);

        Job job = Job.getInstance(getConf());
        job.setJarByClass(PubMed_3.class);
        job.setJobName("PubMed_3");

        job.setMapperClass(Map.class);
        job.setReducerClass(Reduce.class);

        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);

        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[2]));

        job.getConfiguration().setInt("year_of_interest", year_of_interest);

        boolean success = job.waitForCompletion(true);

        return success ? 0 : 1;
    }

    public static void main(String[] args) throws Exception {
        //int exitCode = ToolRunner.run(new PubMed_3(), args);
        //System.exit(exitCode);
        if (args.length != 3) {
            System.err.println("Usage: PubMed_3 <input path> <year of interest> <output path>");
            return;
        }

        int year_of_interest = Integer.parseInt(args[1]);
        Configuration conf = new Configuration();
        Job job = Job.getInstance(conf, "PubMed_3");
        job.setJarByClass(PubMed_3.class);

        job.setMapperClass(Map.class);
        job.setReducerClass(Reduce.class);

        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(IntWritable.class);

        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[2]));

        job.getConfiguration().setInt("year_of_interest", year_of_interest);

        job.waitForCompletion(true);

    }
}

