#!/bin/bash

#
# Build script for sdl1py. If you need to edit this file, create a new copy
# and edit accordingly to your needs.
#

# This is for Python 3.x

cd $(dirname $0)

SDL_CFLAGS=$(sdl-config --cflags)
SDL_LDFLAGS="$(sdl-config --libs) $(pkg-config --libs SDL_image)"

swig -python -py3 $SDL_CFLAGS -I/usr/include src/sdl1py.i

python3 ./setup.py clean

CFLAGS=$SDL_CFLAGS LDFLAGS=$SDL_LDFLAGS python3 ./setup.py build

