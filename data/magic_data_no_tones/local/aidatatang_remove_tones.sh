#!/bin/bash

train_dir=data/local/train
test_dir=data/local/test
IFS=" "
echo "replacing characters with phonemes"
for dir in $train_dir $test_dir; do
  echo "$dir"
  rm -rf $dir/text_temp
  touch $dir/text_temp
  while read p; do
    read -a strarr <<<"$p"
    output="${strarr[0]} "
    input="${strarr[@]:1}"

    result=$(printf '%s\n' "${input//[[:digit:]]/}")
    output+="$result"
    echo "$output" >> $dir/text_temp
  done <$dir/text
done