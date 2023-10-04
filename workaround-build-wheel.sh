#!/usr/bin/env bash

# setup
rm -rf build/
mkdir -p build/the_zord
touch build/the_zord/__init__.py
cp megazords/the_zord/setup.py build/

# build the library
cargo build --manifest-path megazords/the_zord/Cargo.toml --release
cp target/release/libthe_zord.dylib build/the_zord/

# generate the bindings
cargo run --features=uniffi/cli --bin embedded-uniffi-bindgen generate --library target/release/libthe_zord.dylib --language python --out-dir build/the_zord/

# This next part is a workaround for a bug (or a misuse on our part) in the uniffi-bindgen crate.
# Essentially, we need to replace all instances of "from sub_library" with "from .sub_library"
# in the generated python files. This is because the uniffi-bindgen crate generates python
# files that are meant to be used as a standalone library, but we want to use them as a module in our project.

# Directory containing the python files
DIR="build/the_zord"

# Check if the directory exists
if [ ! -d "$DIR" ]; then
    echo "Directory $DIR does not exist"
    exit 1
fi

# Create an array to store the names of all python files in the directory
declare -a filenames

# Iterate over all python files in the specified directory to store names
for file in "$DIR"/*.py; do
    if [ -f "$file" ]; then
        # Extract filename without extension and store it in the array
        filename=$(basename -- "$file")
        name="${filename%.*}"
        filenames+=("$name")
    fi
done

# Iterate over all python files in the specified directory for replacement
for file in "$DIR"/*.py; do
    if [ -f "$file" ]; then
        # Perform find and replace using sed for each filename in the array
        for name in "${filenames[@]}"; do
            sed -i.bak -e "s/from $name/from .$name/g" "$file"
        done
        
        # Optional: Remove backup files created by sed
        # Uncomment the line below if you don't want to keep the backups
        # rm "$file.bak"
    fi
done


# build the wheel
cd build/
python setup.py sdist bdist_wheel
cd ..

# install the wheel
pip install build/dist/the_zord-0.1-py3-none-any.whl --force-reinstall
