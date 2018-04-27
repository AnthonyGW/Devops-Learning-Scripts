#!/bin/bash

function create_directory {
  mkdir -p ~/sample_dir
}

function create_sample_file {
  touch ~/sample_dir/sample.txt
}

function copy_sample_file {
  cp ~/sample_dir/sample.txt ~/sample_dir/copy_sample.txt
}

function list_directory_content {
  ls ~/sample_dir/sample.txt
}

function piping_input {
  export some_input="one two three"
  echo $some_input > ~/sample_dir/sample.txt
  # replace spaces with new lines 
  cat ~/sample_dir/sample.txt | sed -E -e 's/[[:blank:]]+/\
/g'
  cat ~/sample_dir/sample.txt
}

create_directory
create_sample_file
copy_sample_file
piping_input