# UniFFI Examples
I've made this project to create minimal reproductions of problems I'm having so that I might ask others about how to solve them.

## Current Question
How can I build a Python wheel that correctly represents/imports types from other crates?

When I run `maturin build` from `bindings/rust_ffi`, I get a wheel that breaks on import. When inspecting the generated `rust.py` in `target/maturin/uniffi` it's easy to see why - it seems as though uniffi is just assuming those other types exist when nothing has built them.

Going a step further and making a wheel for `bindings/tiny_lib-ffi`, some import problems are resolved, but `rust.py` is attempting to import `FfiConverterTypeTinyLibType` which is not exposed by the `rust_ffi` wheel. Ideally I wouldn't need to install the `tiny_lib` wheel but I'm open to it if there's a path forward this way.

Reading through Maturin's docs I can't see where anything like this is addressed, but it is possible I've overlooked it. Similarly, I can't find anything addressing it in UniFFI's docs; in the section regarding language specifics and external types, Python isn't mentioned.