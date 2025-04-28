#!/bin/bash

# === MyGrep Script ===

show_help() {
    echo "Usage: $0 [options] search_string filename"
    echo "Options:"
    echo "  -n    Show line numbers"
    echo "  -v    Invert match (show lines that do NOT match)"
    echo "  --help    Show this help message"
    exit 1
}

# Check if no arguments given
if [ $# -lt 1 ]; then
    echo "Error: No arguments provided."
    show_help
fi

# Initialize flags
show_line_numbers=false
invert_match=false

# Parse options manually
while [[ "$1" == -* ]]; do
    if [[ "$1" == "--help" ]]; then
        show_help
    fi

    # Remove the first dash
    opts="${1#-}"
    for ((i=0; i<${#opts}; i++)); do
        opt="${opts:$i:1}"
        case "$opt" in
            n) show_line_numbers=true ;;
            v) invert_match=true ;;
            *) echo "Unknown option: -$opt"; show_help ;;
        esac
    done
    shift
done

# After options, two arguments must remain: search_string and filename
if [ $# -lt 2 ]; then
    echo "Error: Missing search string or filename."
    show_help
fi

search="$1"
file="$2"

# Check if file exists
if [ ! -f "$file" ]; then
    echo "Error: File '$file' does not exist."
    exit 2
fi

# Line counter
line_number=0

# Read file line by line
while IFS= read -r line; do
    line_number=$((line_number + 1))
    echo "$line" | grep -i -q "$search"
    match=$?

    if $invert_match; then
        match=$((1 - match))
    fi

    if [ $match -eq 0 ]; then
        if $show_line_numbers; then
            echo "${line_number}:$line"
        else
            echo "$line"
        fi
    fi
done < "$file"
