#!/bin/bash

#The next print_usage function to frint the usage info at --help option
print_usage() {
  echo "Usage: $0 [-n] [-v] pattern filename"
  echo
  echo "Options:"
  echo "  -n        Show line numbers for each matching line"
  echo "  -v        Invert match: show lines that do NOT match"
  echo "  --help    Display this help message"
  exit 0
}

#Check the option --help to print the usage info
if [[ "$1" == "--help" ]]; then
  print_usage
fi

#Default value for options to run without -n or -v
options=""

#Option parsing using getopts to use -n and -v options
while getopts "nv" opt; do
  case $opt in
    n) options="$options -n" ;;
    v) options="$options -v" ;;
    *) echo "Usage: $0 [-n] [-v] pattern filename"; exit 1 ;;
  esac
done

#Shift away the options so $1 and $2 are pattern and filename
shift $((OPTIND-1))

#Check that the user pass the pattern and filename (validating arguments)
if [[ $# -ne 2 ]]; then
  echo "Error: pattern and filename are required."
  print_usage
fi

#Set the first input to be pattern and second input is the filename
pattern=$1
filename=$2

#Run the grep command
grep -i  $options "$pattern" "$filename"

