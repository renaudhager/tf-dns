#!/bin/bash
terraform remote config \
  -backend=s3 \
  -backend-config="bucket=r.hager-tf" \
  -backend-config="key=tf/state_file/dev/tf-dns.tfstate" \
  -backend-config="region=us-east-2"
