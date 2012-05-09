#!/usr/bin/env python
#-*- coding: utf-8 -*-

import os, sys

try:
    import sdl1py
except ImportError:
    INCPATH = '../build'
    for y in [x for x in os.listdir(INCPATH) if x.startswith('lib.')]:
        sys.path.append(os.path.join(INCPATH, y))
    import sdl1py

def main():
    assert 0 == sdl1py.SDL_Init(sdl1py.SDL_INIT_EVERYTHING)
    screen = sdl1py.SDL_SetVideoMode(600, 400, 0, 0)
    assert screen != None

    run = True
    ev = sdl1py.SDL_Event()
    bgcolor = sdl1py.SDL_MapRGB(screen.format, 0, 0, 64)

    #img = sdl1py.SDL_LoadBMP("pic1.bmp")
    img2 = sdl1py.IMG_Load("pic1.png")
    img = sdl1py.SDL_DisplayFormat(img2)
    assert img != None
    sdl1py.SDL_FreeSurface(img2)

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

