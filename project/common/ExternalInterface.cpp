#ifndef IPHONE
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif

#include <hx/CFFI.h>
#include <steam/steam_api.h>

value Steamworks_Init(){
	SteamAPI_Init(); return alloc_null();
}

DEFINE_PRIM(Steamworks_Init, 0);
