#!/bin/bash

train_dir=data/local/train
dev_dir=data/local/dev
test_dir=data/local/test
IFS=" "
echo "replacing characters with phonemes"
for dir in $train_dir $test_dir $dev_dir; do
  echo "$dir"
  rm -rf $dir/text_temp
  touch $dir/text_temp
  while read p; do
    read -a strarr <<<"$p"
    output="${strarr[0]} "
    for val in "${strarr[@]:1}"; do
      match="$(grep -w "^$val" subset_data/lexicon.txt)"
      IFS="\n"
      read -a matcharr <<<"$match"
      translation="${matcharr[0]}"
      string="$( cut -d ' ' -f 2- <<< "$translation" )"
      output+=" ${string}"
      IFS=" "
    done
    echo "$output" >> $dir/text_temp
  done <$dir/text
  cp -f $dir/text $dir/text_characters
  cp -f $dir/text_temp $dir/text
  rm -rf $dir/text_temp
done 
echo "done"