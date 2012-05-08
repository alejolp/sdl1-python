%module sdl1py

%{
#define SWIG_FILE_WITH_INIT
#include "SDL.h"
#include "sdl1py.h"
%}

%include "typemaps.i"

/* */

#define extern 
#define DECLSPEC 
#define SDLCALL

/* Data types */

enum SDL_bool {
    SDL_FALSE = 0,
    SDL_TRUE  = 1
};

/* FIXME: This is wrong. I should not be hard-coding the data types like this, 
          but don't know how to tell SWIG wich data type the compiler picked.

          %include "stdint.h" won't work. */

/*
typedef char int8_t;
typedef unsigned char uint8_t;
typedef short int16_t;
typedef unsigned short uint16_t;
typedef int int32_t;
typedef unsigned uint32_t;
*/

%include "stdint.i"

typedef int8_t Sint8;
typedef uint8_t Uint8;
typedef int16_t Sint16;
typedef uint16_t Uint16;
typedef int32_t Sint32;
typedef uint32_t Uint32;

/* SDL Init */

#define SDL_INIT_TIMER          0x00000001
#define SDL_INIT_AUDIO          0x00000010
#define SDL_INIT_VIDEO          0x00000020
#define SDL_INIT_JOYSTICK       0x00000200
#define SDL_INIT_HAPTIC         0x00001000
#define SDL_INIT_NOPARACHUTE    0x00100000
#define SDL_INIT_EVERYTHING     0x0000FFFF

Uint32 SDL_Init(Uint32 flags);
int SDL_InitSubSystem(Uint32 flags);
void SDL_QuitSubSystem(Uint32 flags);
int SDL_WasInit(Uint32 flags);
void SDL_Quit(void);

/* Errors */

void SDL_SetError(const char* fmt);
const char * SDL_GetError(void);
void SDL_ClearError(void);

/* Version */

typedef struct SDL_version {
    unsigned char major;
    unsigned char minor;
    unsigned char patch;
} SDL_version;

%rename(SDL_VERSION) sdl1py_SDL_VERSION;
%rename(SDL_VERSIONNUM) sdl1py_SDL_VERSIONNUM;
%rename(SDL_COMPILEDVERSION) sdl1py_SDL_COMPILEDVERSION;
%rename(SDL_VERSION_ATLEAST) sdl1py_SDL_VERSION_ATLEAST;

%inline %{
void sdl1py_SDL_VERSION(SDL_version* v) {
    SDL_VERSION(v);
}

int sdl1py_SDL_VERSIONNUM(int x, int y, int z) {
    return SDL_VERSIONNUM(x, y, z);
}

int sdl1py_SDL_COMPILEDVERSION(void) {
    return SDL_COMPILEDVERSION;
}

int sdl1py_SDL_VERSION_ATLEAST(int x, int y, int z) {
    return SDL_VERSION_ATLEAST(x, y, z);
}
%}

SDL_version * SDL_Linked_Version(void);

/* Active */

#define SDL_APPMOUSEFOCUS   0x01
#define SDL_APPINPUTFOCUS   0x02
#define SDL_APPACTIVE       0x04

int SDL_GetAppState(void);

/* Endian */

%constant int SDL_LIL_ENDIAN = SDL_LIL_ENDIAN;
%constant int SDL_BIG_ENDIAN = SDL_BIG_ENDIAN;
%constant int SDL_BYTEORDER = SDL_BYTEORDER;

%rename(SDL_Swap16) sdl1py_SDL_Swap16;
%inline %{
    int sdl1py_SDL_Swap16(int x) { return SDL_Swap16(x); }
%}

%rename(SDL_Swap32) sdl1py_SDL_Swap32;
%inline %{
    int sdl1py_SDL_Swap32(int x) { return SDL_Swap32(x); }
%}

%rename(SDL_Swap64) sdl1py_SDL_Swap64;
%inline %{
    int sdl1py_SDL_Swap64(int x) { return SDL_Swap64(x); }
%}

%rename(SDL_SwapLE16) sdl1py_SDL_SwapLE16;
%inline %{
    int sdl1py_SDL_SwapLE16(int x) { return SDL_SwapLE16(x); }
%}

%rename(SDL_SwapLE32) sdl1py_SDL_SwapLE32;
%inline %{
    int sdl1py_SDL_SwapLE32(int x) { return SDL_SwapLE32(x); }
%}

%rename(SDL_SwapLE64) sdl1py_SDL_SwapLE64;
%inline %{
    int sdl1py_SDL_SwapLE64(int x) { return SDL_SwapLE64(x); }
%}

%rename(SDL_SwapBE16) sdl1py_SDL_SwapBE16;
%inline %{
    int sdl1py_SDL_SwapBE16(int x) { return SDL_SwapBE16(x); }
%}

%rename(SDL_SwapBE32) sdl1py_SDL_SwapBE32;
%inline %{
    int sdl1py_SDL_SwapBE32(int x) { return SDL_SwapBE32(x); }
%}

%rename(SDL_SwapBE64) sdl1py_SDL_SwapBE64;
%inline %{
    int sdl1py_SDL_SwapBE64(int x) { return SDL_SwapBE64(x); }
%}

/* CPU Info */

int SDL_HasRDTSC(void);
int SDL_HasMMX(void);
int SDL_HasMMXExt(void);
int SDL_Has3DNow(void);
int SDL_Has3DNowExt(void);
int SDL_HasSSE(void);
int SDL_HasSSE2(void);
int SDL_HasAltiVec(void);

/* Events */

#define SDL_RELEASED    0
#define SDL_PRESSED 1

enum SDL_EventType {
       SDL_NOEVENT = 0,         /**< Unused (do not remove) */
       SDL_ACTIVEEVENT,         /**< Application loses/gains visibility */
       SDL_KEYDOWN,         /**< Keys pressed */
       SDL_KEYUP,           /**< Keys released */
       SDL_MOUSEMOTION,         /**< Mouse moved */
       SDL_MOUSEBUTTONDOWN,     /**< Mouse button pressed */
       SDL_MOUSEBUTTONUP,       /**< Mouse button released */
       SDL_JOYAXISMOTION,       /**< Joystick axis motion */
       SDL_JOYBALLMOTION,       /**< Joystick trackball motion */
       SDL_JOYHATMOTION,        /**< Joystick hat position change */
       SDL_JOYBUTTONDOWN,       /**< Joystick button pressed */
       SDL_JOYBUTTONUP,         /**< Joystick button released */
       SDL_QUIT,            /**< User-requested quit */
       SDL_SYSWMEVENT,          /**< System specific event */
       SDL_EVENT_RESERVEDA,     /**< Reserved for future use.. */
       SDL_EVENT_RESERVEDB,     /**< Reserved for future use.. */
       SDL_VIDEORESIZE,         /**< User resized video mode */
       SDL_VIDEOEXPOSE,         /**< Screen needs to be redrawn */
       SDL_EVENT_RESERVED2,     /**< Reserved for future use.. */
       SDL_EVENT_RESERVED3,     /**< Reserved for future use.. */
       SDL_EVENT_RESERVED4,     /**< Reserved for future use.. */
       SDL_EVENT_RESERVED5,     /**< Reserved for future use.. */
       SDL_EVENT_RESERVED6,     /**< Reserved for future use.. */
       SDL_EVENT_RESERVED7,     /**< Reserved for future use.. */
       /** Events SDL_USEREVENT through SDL_MAXEVENTS-1 are for your use */
       SDL_USEREVENT = 24,
       /** This last event is only for bounding internal arrays
    *  It is the number of bits in the event mask datatype -- Uint32
        */
       SDL_NUMEVENTS = 32
};

#define SDL_ALLEVENTS       0xFFFFFFFF

%rename(SDL_EVENTMASK) sdl1py_SDL_EVENTMASK;
%inline %{
    int sdl1py_SDL_EVENTMASK(int x) { return SDL_EVENTMASK(x); }
%}

typedef struct SDL_ActiveEvent {
    Uint8 type; /**< SDL_ACTIVEEVENT */
    Uint8 gain; /**< Whether given states were gained or lost (1/0) */
    Uint8 state;    /**< A mask of the focus states */
} SDL_ActiveEvent;

typedef struct SDL_KeyboardEvent {
    Uint8 type; /**< SDL_KEYDOWN or SDL_KEYUP */
    Uint8 which;    /**< The keyboard device index */
    Uint8 state;    /**< SDL_PRESSED or SDL_RELEASED */
    SDL_keysym keysym;
} SDL_KeyboardEvent;

typedef struct SDL_MouseMotionEvent {
    Uint8 type; /**< SDL_MOUSEMOTION */
    Uint8 which;    /**< The mouse device index */
    Uint8 state;    /**< The current button state */
    Uint16 x, y;    /**< The X/Y coordinates of the mouse */
    Sint16 xrel;    /**< The relative motion in the X direction */
    Sint16 yrel;    /**< The relative motion in the Y direction */
} SDL_MouseMotionEvent;

typedef struct SDL_MouseButtonEvent {
    Uint8 type; /**< SDL_MOUSEBUTTONDOWN or SDL_MOUSEBUTTONUP */
    Uint8 which;    /**< The mouse device index */
    Uint8 button;   /**< The mouse button index */
    Uint8 state;    /**< SDL_PRESSED or SDL_RELEASED */
    Uint16 x, y;    /**< The X/Y coordinates of the mouse at press time */
} SDL_MouseButtonEvent;

typedef struct SDL_JoyAxisEvent {
    Uint8 type; /**< SDL_JOYAXISMOTION */
    Uint8 which;    /**< The joystick device index */
    Uint8 axis; /**< The joystick axis index */
    Sint16 value;   /**< The axis value (range: -32768 to 32767) */
} SDL_JoyAxisEvent;

typedef struct SDL_JoyBallEvent {
    Uint8 type; /**< SDL_JOYBALLMOTION */
    Uint8 which;    /**< The joystick device index */
    Uint8 ball; /**< The joystick trackball index */
    Sint16 xrel;    /**< The relative motion in the X direction */
    Sint16 yrel;    /**< The relative motion in the Y direction */
} SDL_JoyBallEvent;

typedef struct SDL_JoyHatEvent {
    Uint8 type; /**< SDL_JOYHATMOTION */
    Uint8 which;    /**< The joystick device index */
    Uint8 hat;  /**< The joystick hat index */
    Uint8 value;    /**< The hat position value:
             *   SDL_HAT_LEFTUP   SDL_HAT_UP       SDL_HAT_RIGHTUP
             *   SDL_HAT_LEFT     SDL_HAT_CENTERED SDL_HAT_RIGHT
             *   SDL_HAT_LEFTDOWN SDL_HAT_DOWN     SDL_HAT_RIGHTDOWN
             *  Note that zero means the POV is centered.
             */
} SDL_JoyHatEvent;

typedef struct SDL_JoyButtonEvent {
    Uint8 type; /**< SDL_JOYBUTTONDOWN or SDL_JOYBUTTONUP */
    Uint8 which;    /**< The joystick device index */
    Uint8 button;   /**< The joystick button index */
    Uint8 state;    /**< SDL_PRESSED or SDL_RELEASED */
} SDL_JoyButtonEvent;

typedef struct SDL_ResizeEvent {
    Uint8 type; /**< SDL_VIDEORESIZE */
    int w;      /**< New width */
    int h;      /**< New height */
} SDL_ResizeEvent;

typedef struct SDL_ExposeEvent {
    Uint8 type; /**< SDL_VIDEOEXPOSE */
} SDL_ExposeEvent;

typedef struct SDL_QuitEvent {
    Uint8 type; /**< SDL_QUIT */
} SDL_QuitEvent;

typedef struct SDL_UserEvent {
    Uint8 type; /**< SDL_USEREVENT through SDL_NUMEVENTS-1 */
    int code;   /**< User defined event code */
    void *data1;    /**< User defined data pointer */
    void *data2;    /**< User defined data pointer */
} SDL_UserEvent;

typedef union SDL_Event {
    Uint8 type;
    SDL_ActiveEvent active;
    SDL_KeyboardEvent key;
    SDL_MouseMotionEvent motion;
    SDL_MouseButtonEvent button;
    SDL_JoyAxisEvent jaxis;
    SDL_JoyBallEvent jball;
    SDL_JoyHatEvent jhat;
    SDL_JoyButtonEvent jbutton;
    SDL_ResizeEvent resize;
    SDL_ExposeEvent expose;
    SDL_QuitEvent quit;
    SDL_UserEvent user;
    SDL_SysWMEvent syswm;
} SDL_Event;

void SDL_PumpEvents(void);

enum SDL_eventaction {
    SDL_ADDEVENT,
    SDL_PEEKEVENT,
    SDL_GETEVENT
};

int SDL_PeepEvents(SDL_Event *events, int numevents, SDL_eventaction action, Uint32 mask);
int SDL_PollEvent(SDL_Event *event);
int SDL_WaitEvent(SDL_Event *event);
int SDL_PushEvent(SDL_Event *event);

/*
typedef int (*SDL_EventFilter)(const SDL_Event *event);
void SDL_SetEventFilter(SDL_EventFilter filter);
SDL_EventFilter SDL_GetEventFilter(void);
*/

#define SDL_QUERY   -1
#define SDL_IGNORE   0
#define SDL_DISABLE  0
#define SDL_ENABLE   1

Uint8 SDL_EventState(Uint8 type, int state);

/* Quit */

%rename(SDL_QuitRequested) sdl1py_SDL_QuitRequested;
%inline %{
    int sdl1py_SDL_QuitRequested(void) { return SDL_QuitRequested(); }
%}

/* Keyboard */

%include "SDL_keysym.h"

#undef KMOD_CTRL
#undef KMOD_SHIFT
#undef KMOD_ALT
#undef KMOD_META

%constant int KMOD_CTRL = KMOD_CTRL;
%constant int KMOD_SHIFT = KMOD_SHIFT;
%constant int KMOD_ALT = KMOD_ALT;
%constant int KMOD_META = KMOD_META;

typedef struct SDL_keysym {
    Uint8 scancode;         /**< hardware specific scancode */
    SDLKey sym;         /**< SDL virtual keysym */
    SDLMod mod;         /**< current key modifiers */
    Uint16 unicode;         /**< translated character */
} SDL_keysym;

#define SDL_ALL_HOTKEYS     0xFFFFFFFF

int SDL_EnableUNICODE(int enable);

#define SDL_DEFAULT_REPEAT_DELAY    500
#define SDL_DEFAULT_REPEAT_INTERVAL 30

int SDL_EnableKeyRepeat(int delay, int interval);
void SDL_GetKeyRepeat(int *delay, int *interval);

Uint8 * SDL_GetKeyState(int *numkeys);
SDLMod  SDL_GetModState(void);
void    SDL_SetModState(SDLMod modstate);
char *  SDL_GetKeyName(SDLKey key);

/* Mouse */

typedef struct SDL_Cursor {
    SDL_Rect area;          /**< The area of the mouse cursor */
    Sint16 hot_x, hot_y;        /**< The "tip" of the cursor */
    Uint8 *data;            /**< B/W cursor data */
    Uint8 *mask;            /**< B/W cursor mask */
    Uint8 *save[2];         /**< Place to save cursor area */
    WMcursor *wm_cursor;        /**< Window-manager cursor */
} SDL_Cursor;

Uint8 SDL_GetMouseState(int *OUTPUT, int *OUTPUT);

Uint8 SDL_GetRelativeMouseState(int *OUTPUT, int *OUTPUT);

void  SDL_WarpMouse(Uint16 x, Uint16 y);

SDL_Cursor* SDL_CreateCursor(Uint8 *data, Uint8 *mask, int w, int h, int hot_x, int hot_y);

void SDL_SetCursor(SDL_Cursor *cursor);

SDL_Cursor* SDL_GetCursor(void);

void SDL_FreeCursor(SDL_Cursor *cursor);

int SDLCALL SDL_ShowCursor(int toggle);

#define SDL_BUTTON_LEFT     1
#define SDL_BUTTON_MIDDLE   2
#define SDL_BUTTON_RIGHT    3
#define SDL_BUTTON_WHEELUP  4
#define SDL_BUTTON_WHEELDOWN    5
#define SDL_BUTTON_X1       6
#define SDL_BUTTON_X2       7

%rename(SDL_BUTTON) sdl1py_SDL_BUTTON;
%inline %{
    int sdl1py_SDL_BUTTON(int x) { return SDL_BUTTON(x); }
%}

%constant int SDL_BUTTON_LMASK = SDL_BUTTON_LMASK;
%constant int SDL_BUTTON_MMASK = SDL_BUTTON_MMASK;
%constant int SDL_BUTTON_RMASK = SDL_BUTTON_RMASK;
%constant int SDL_BUTTON_X1MASK = SDL_BUTTON_X1MASK;
%constant int SDL_BUTTON_X2MASK = SDL_BUTTON_X2MASK;

/* Joystick */

int SDL_JoystickGetBall(SDL_Joystick *joystick, int ball, int *OUTPUT, int *OUTPUT);

%ignore SDL_JoystickGetBall;
%include "SDL_joystick.h"

/* Platform */

/* 
Generated code from "SDL_platform.h" 
$ grep "define " SDL_platform.h  | cut -d" " -f2 | cut -f1
*/

%inline %{
    const char* SDL_GetPlatformName(void) {

#if defined(__BEOS__)
return "__BEOS__";
#endif

#if defined(__MACOS__)
return "__MACOS__";
#endif

#if defined(__OS2__)
return "__OS2__";
#endif

#if defined(__SOLARIS__)
return "__SOLARIS__";
#endif

#if defined(__HAIKU__)
return "__HAIKU__";
#endif

#if defined(__OPENBSD__)
return "__OPENBSD__";
#endif

#if defined(__AIX__)
return "__AIX__";
#endif

#if defined(__WIN32__)
return "__WIN32__";
#endif

#if defined(__DREAMCAST__)
return "__DREAMCAST__";
#endif

#if defined(__IRIX__)
return "__IRIX__";
#endif

#if defined(__LINUX__)
return "__LINUX__";
#endif

#if defined(__RISCOS__)
return "__RISCOS__";
#endif

#if defined(__NETBSD__)
return "__NETBSD__";
#endif

#if defined(__OSF__)
return "__OSF__";
#endif

#if defined(__FREEBSD__)
return "__FREEBSD__";
#endif

#if defined(__HPUX__)
return "__HPUX__";
#endif

#if defined(__BSDI__)
return "__BSDI__";
#endif

#if defined(__QNXNTO__)
return "__QNXNTO__";
#endif

#if defined(__MACOSX__)
return "__MACOSX__";
#endif

    return "";
    }
%}

/* Video */

%include "SDL_video.h"

%rename(SDL_MUSTLOCK) sdl1py_SDL_MUSTLOCK;
%inline %{
    int sdl1py_SDL_MUSTLOCK(SDL_Surface* s) { return SDL_MUSTLOCK(s); }
%}

%rename(SDL_LoadBMP) sdl1py_SDL_LoadBMP;
%inline %{
    SDL_Surface* sdl1py_SDL_LoadBMP(const char* fname) { 
        return SDL_LoadBMP(fname);
    }
%}

/* SDL_BlitSurface is a #defined macro. */
#undef SDL_BlitSurface

%rename(SDL_BlitSurface) sdl1py_SDL_BlitSurface;
%inline %{
    int sdl1py_SDL_BlitSurface(SDL_Surface* aaa, SDL_Rect* bbb, SDL_Surface* ccc, SDL_Rect* ddd) {
        return SDL_BlitSurface(aaa, bbb, ccc, ddd);
    }
%}

/* Timer */

%include "SDL_timer.h"


