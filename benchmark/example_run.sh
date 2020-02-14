#!/bin/bash

N_DATASETS=$1
OUTPUT_DIR="simresults"
mkdir -p $OUTPUT_DIR

for (( i=1; i<=$N_DATASETS; i++ ))
do
    Rscript scripts/sample_dags.R --filename dag_$i.rds --nodes 20 --parents 2 --seed $i --output_dir $OUTPUT_DIR
    Rscript scripts/sample_bayesian_network_for_dag.R --filename_dag  $OUTPUT_DIR/dag_$i.rds --filename bn_$i.rds --seed 1 --output_dir $OUTPUT_DIR
    Rscript scripts/sample_data.R --filename data_$i.csv --filename_bn $OUTPUT_DIR/bn_$i.rds --samples 200 --seed 1 --output_dir $OUTPUT_DIR
done

for (( i=1; i<=$N_DATASETS; i++ ))
do
    Rscript example_simulations_refactored.R --filename_dag $OUTPUT_DIR/dag_$i.rds --filename_data  $OUTPUT_DIR/data_$i.csv --blip_max_time 10 --seed 1 --replicate $i --output_dir $OUTPUT_DIR
done

Rscript scripts/plot_results.R --directory $OUTPUT_DIR

