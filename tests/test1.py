#!/usr/bin/env python
#-*- coding: utf-8 -*-

import os, sys

try:
    import sdl1py
except ImportError:
    sys.path.append('../build/lib.linux-x86_64-2.7')
    import sdl1py

def main():
    assert 0 == sdl1py.SDL_Init(sdl1py.SDL_INIT_EVERYTHING)
    screen = sdl1py.SDL_SetVideoMode(600, 400, 0, 0)
    assert screen != None

    run = True
    ev = sdl1py.SDL_Event()
    bgcolor = sdl1py.SDL_MapRGB(screen.format, 0, 0, 64)
    img = sdl1py.SDL_LoadBMP("pic1.bmp")
    imgpos = sdl1py.SDL_Rect()
    imgpos.w = img.w
    imgpos.h = img.h
    vx = vy = 1

    while run:
        while sdl1py.SDL_PollEvent(ev):
            if ev.type == sdl1py.SDL_QUIT:
                run = False
            if ev.type == sdl1py.SDL_KEYDOWN:
                if ev.key.keysym.sym == sdl1py.SDLK_ESCAPE:
                    run = False

        imgpos.x = imgpos.x + vx
        if imgpos.x >= screen.w - img.w - 1 or imgpos.x <= 0:
            vx *= -1
        imgpos.y = imgpos.y + vy
        if imgpos.y >= screen.h - img.h - 1 or imgpos.y <= 0:
            vy *= -1

        assert 0 == sdl1py.SDL_FillRect(screen, None, bgcolor)
        assert 0 == sdl1py.SDL_BlitSurface(img, None, screen, imgpos)
        assert 0 == sdl1py.SDL_Flip(screen)
        sdl1py.SDL_Delay(1000 / 50);

    assert 0 == sdl1py.SDL_FreeSurface(img)
    sdl1py.SDL_Quit()

if __name__ == '__main__':
    try:
        main()
    except AssertionError:
        print sdl1py.SDL_GetError()

