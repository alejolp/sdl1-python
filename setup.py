#!/usr/bin/env python

from distutils.core import setup, Extension

sdl1py_module = Extension('_sdl1py',
                           sources=['src/sdl1py.c', 'src/sdl1py_wrap.c'],
                           )

setup (name = 'sdl1py',
       version = '0.1',
       author      = "Alejandro Santos",
       description = """SDL1 Python Bindings""",
       ext_modules = [sdl1py_module],
       py_modules = ["sdl1py"],
       package_dir = {'': 'src'},
       )

