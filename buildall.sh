#!/bin/bash

#
# Build script for sdl1py. If you need to edit this file, create a new copy
# and edit accordingly to your needs.
#

cd $(dirname $0)

SDL_CFLAGS=$(sdl-config --cflags)
SDL_LDFLAGS="$(sdl-config --libs) $(pkg-config --libs SDL_image)"

swig -python $SDL_CFLAGS -I/usr/include src/sdl1py.i

./setup.py clean

CFLAGS=$SDL_CFLAGS LDFLAGS=$SDL_LDFLAGS ./setup.py build

