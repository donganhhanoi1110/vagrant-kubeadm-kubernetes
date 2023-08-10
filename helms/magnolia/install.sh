#!/usr/bin/env bash
echo ">>Install magnolia $(date +%Y_%m_%d:%k:%M:%S)<<"
#if helm not install
#helm repo add mironet https://charts.mirohost.ch/
export DEPLOYMENT=dev
export HELM_CHART_VERSION=1.7.1
helm upgrade -i ${DEPLOYMENT} mironet/magnolia-helm --version ${HELM_CHART_VERSION} -f values.yaml --create-namespace -n ${DEPLOYMENT}