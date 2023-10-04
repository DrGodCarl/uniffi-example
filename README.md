# UniFFI Examples
I've made this project to create minimal reproductions of problems I'm having so that I might ask others about how to solve them.

## Current Question
How can I build a Python wheel that correctly represents/imports types from other crates?

When I run the build/install script (`build-and-install-megazord-wheel.sh`), I get a wheel that breaks on import. When inspecting the generated `rust.py` contained within it's clear why - it's importing from `tiny_lib`, which is the name of an adjacent file, but the import looks for another library with that name and fails when it doesn't find it.

The only fix I've found is to edit `rust.py` to import from `.tiny_lib` to specify a relative import. While I _can_ script this, it's less than ideal.

Reading through UniFFI's docs I can't see where anything like this is addressed, but it is possible I've overlooked it. It's also possible I'm "holding it wrong" and there's some other way to structure this wheel to allow these files to interact.