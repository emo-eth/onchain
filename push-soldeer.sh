#!/bin/bash

# Function to parse TOML file and extract name and version
parse_toml() {
    local toml_file=$1
    local table_name=$2

    # Check if the TOML file exists
    if [ ! -f "$toml_file" ]; then
        echo "TOML file not found: $toml_file"
        return 1
    fi

    # Extract name and version from the TOML file under the specified table
    name=$(awk -F' = ' -v table="$table_name" '$0 ~ "^"table {found=1} found && $1 ~ /^name$/ {print $2; exit}' "$toml_file" | tr -d '"')
    version=$(awk -F' = ' -v table="$table_name" '$0 ~ "^"table {found=1} found && $1 ~ /^version$/ {print $2; exit}' "$toml_file" | tr -d '"')

    # Check if name and version are set
    if [ -z "$name" ] || [ -z "$version" ]; then
        echo "Name or version not found under the $table_name table in $toml_file"
        return 1
    fi

    echo "Name: $name"
    echo "Version: $version"
}

# Search for foundry.toml or soldeer.toml
if [ -f "foundry.toml" ]; then
    toml_file="foundry.toml"
elif [ -f "soldeer.toml" ]; then
    toml_file="soldeer.toml"
else
    echo "Neither foundry.toml nor soldeer.toml found in the current directory"
    exit 1
fi

# Parse the TOML file and extract name and version
if ! parse_toml "$toml_file" "[info]"; then
    exit 1
fi

# Perform the soldeer push action
echo "Performing: soldeer push $name~$version"
forge soldeer push "$name~$version"
