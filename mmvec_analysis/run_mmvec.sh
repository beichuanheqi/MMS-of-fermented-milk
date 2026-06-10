#!/bin/bash
microbe_file=./data/filter_asv.biom
metabolite_file=./data/oav.biom
metadata_file=./data/sample_metadata.txt
latent_dim=2
learning_rate=1e-3
min_feature_count=0
batch_size=50
epochs=2000
checkpoint_interval=1
summary_interval=1
mmvec paired-omics \
        --microbe-file $microbe_file \
        --metabolite-file $metabolite_file \
        --metadata-file $metadata_file \
        --training-column Testing \
        --latent-dim $latent_dim \
        --learning-rate $learning_rate \
        --min-feature-count $min_feature_count \
        --batch-size $batch_size \
        --epochs $epochs \
        --summary-dir result/epoch${epochs}_ld${latent_dim} \
        --summary-interval $summary_interval \
        --checkpoint-interval $checkpoint_interval
