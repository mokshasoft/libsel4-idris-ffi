#!/bin/sh

grep -rh "." * --include=gen_config.h |
    awk '$1 ~ /#define/ {print "-D" $2 "=" $3}' |
    tr '\n' ' '
