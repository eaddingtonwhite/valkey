#!/bin/sh
# Build the GoogleTest unit-test binary, then run it with whatever filter was appended.
#
# One command, because mo-eval runs the declared test command directly (no shell) and a probe
# appends only its filter. The build has to be part of it: an additive change's start state is a
# tree that does NOT compile, and a build done in `setup_command` would report that as an
# environment that could not be prepared rather than as the task failing.
set -e
make -C src/unit valkey-unit-gtests -j"$(getconf _NPROCESSORS_ONLN 2>/dev/null || echo 2)"
exec ./src/unit/valkey-unit-gtests "$@"
