#!/usr/bin/env bash

psql postgresql://localhost:9113/bigbluedisk -f ~/search_objects.sql 2>&1