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

# build the wheel
cd build/
python setup.py sdist bdist_wheel
cd ..

# install the wheel
pip install build/dist/the_zord-0.1-py3-none-any.whl --force-reinstall
