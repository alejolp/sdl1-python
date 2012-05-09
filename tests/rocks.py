#!/usr/bin/env python
#-*- coding: utf-8 -*-

"""
Rocks - Example sdl1py library program.
Alejandro Santos - alejolp@alejolp.com.ar
This program is part of the examples included with sdl1py library.
"""

import os, sys, random

try:
    import sdl1py
except ImportError:
    # Some import magic if the module is not system wide installed.
    INCPATH = os.path.join(os.path.dirname(__file__), '..', 'build')
    PYVER = sys.version[0:3]
    for y in os.listdir(INCPATH):
        if y.startswith('lib.') and y.endswith(PYVER):
            sys.path.append(os.path.join(INCPATH, y))
    import sdl1py

screen = None

class Rock(object):
    def __init__(self, x, y, w, h):
        self.pos = sdl1py.SDL_Rect()
        self.pos.x = x
        self.pos.y = y
        self.pos.w = w
        self.pos.h = h
        self.vx = 1 if random.randint(0,1) else -1
        self.vy = 1 if random.randint(0,1) else -1

    def update(self):
        imgpos = self.pos
        imgpos.x = imgpos.x + self.vx
        if imgpos.x >= screen.w - imgpos.w - 1 or imgpos.x <= 0:
            self.vx *= -1
        imgpos.y = imgpos.y + self.vy
        if imgpos.y >= screen.h - imgpos.h - 1 or imgpos.y <= 0:
            self.vy *= -1

def load_image(file_name):
    img2 = sdl1py.IMG_Load(file_name)
    img = sdl1py.SDL_DisplayFormat(img2)
    assert img != None
    sdl1py.SDL_FreeSurface(img2)
    return img

def draw_stars(surf, stars, color):
    if sdl1py.SDL_MUSTLOCK(surf):
        sdl1py.SDL_LockSurface(surf)

    # While no exceptions should rise here, it is important to keep in mind
    # that a locked surface should always be unlocked in the context of 
    # exceptions.

    try:
        for x, y in stars:
            sdl1py.SDL_PutPixel(surf, x, y, color)
    finally:
        if sdl1py.SDL_MUSTLOCK(surf):
            sdl1py.SDL_UnlockSurface(surf)

def main():
    global screen

    assert 0 == sdl1py.SDL_Init(sdl1py.SDL_INIT_EVERYTHING)
    screen = sdl1py.SDL_SetVideoMode(600, 400, 0, sdl1py.SDL_ANYFORMAT)
    assert screen != None

    run = True
    ev = sdl1py.SDL_Event()
    bgcolor = sdl1py.SDL_MapRGB(screen.format, 0, 0, 0)
    starcolor = sdl1py.SDL_MapRGB(screen.format, 128, 128, 160)
    
    img = load_image("pic1.png")
    sdl1py.SDL_SetColorKey(img, sdl1py.SDL_SRCCOLORKEY, \
        sdl1py.SDL_GetPixel(img, 0, 0))

    stars = [(random.randint(0, screen.w-1), random.randint(0, screen.h-1)) \
        for x in xrange(100)]

    rocks = [Rock(random.randint(0, screen.w - img.w - 1), \
        random.randint(0, screen.h - img.h - 1), img.w, img.h) \
        for x in xrange(50)]

    while run:
        while sdl1py.SDL_PollEvent(ev):
            if ev.type == sdl1py.SDL_QUIT:
                run = False
            elif ev.type == sdl1py.SDL_KEYDOWN:
                if ev.key.keysym.sym == sdl1py.SDLK_ESCAPE:
                    run = False
            elif ev.type == sdl1py.SDL_MOUSEBUTTONDOWN:
                x, y = ev.button.x, ev.button.y
                for i, r in reversed(list(enumerate(rocks))):
                    if r.pos.x <= x and r.pos.x + r.pos.w > x:
                        if r.pos.y <= y and r.pos.y + r.pos.h > y:
                            del rocks[i]
                            break

        # Update rocks positions
        for r in rocks:
            r.update()

        # Clear screen
        assert 0 == sdl1py.SDL_FillRect(screen, None, bgcolor)

        draw_stars(screen, stars, starcolor)

        # Blit all the rocks
        for r in rocks:
            assert 0 == sdl1py.SDL_BlitSurface(img, None, screen, r.pos)

        # Update screen
        assert 0 == sdl1py.SDL_Flip(screen)
        sdl1py.SDL_Delay(1000 / 50);

    assert 0 == sdl1py.SDL_FreeSurface(img)
    sdl1py.SDL_Quit()

if __name__ == '__main__':
    try:
        main()
    except AssertionError:
        print sdl1py.SDL_GetError()

