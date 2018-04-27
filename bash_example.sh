#!/bin/bash

set -eo pipefail

function create_directory {
  echo "Making HOME/sample_dir"
  mkdir -p ~/sample_dir
}

function create_sample_file {
  echo "Making HOME/sample_dir/sample.txt"
  touch ~/sample_dir/sample.txt
}

function copy_sample_file {
  echo "Copying HOME/sample_dir/sample.txt"
  cp ~/sample_dir/sample.txt ~/sample_dir/copy_sample.txt
}

function list_directory_content {
  echo "Content of sample_dir:"
  ls ~/sample_dir
}

function piping_input {
  export some_input="one two three"
  echo $some_input > ~/sample_dir/sample.txt

  echo "Replace spaces with new lines"
  cat ~/sample_dir/sample.txt | sed -E -e 's/[[:blank:]]+/\
/g'

  echo "Text in sample.txt"
  cat ~/sample_dir/sample.txt
}

create_directory
create_sample_file
copy_sample_file
list_directory_content
piping_input