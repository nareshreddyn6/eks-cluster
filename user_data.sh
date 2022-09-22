#!/bin/bash
# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

set -o xtrace
systemctl stop kubelet
/etc/eks/bootstrap.sh ${cluster_name} 

