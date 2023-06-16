#!/bin/sh

link="https://$(aws sts get-caller-identity --query 'Account' --output text).dkr.ecr.$(aws configure get region).amazonaws.com"
aws ecr get-login-password | docker login -u AWS --password-stdin $link
