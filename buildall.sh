#!/bin/bash

#
# Build script for sdl1py. If you need to edit this file, create a new copy
# and edit accordingly to your needs.
#

cd $(dirname $0)

SDL_CFLAGS=$(sdl-config --cflags)
SDL_LDFLAGS=$(sdl-config --libs)

swig -python $SDL_CFLAGS -I/usr/include sdl1py.i

./setup.py clean

CFLAGS=$SDL_CFLAGS LDFLAGS=$SDL_LDFLAGS ./setup.py build

