//بسم الله الرحمن الرحيم
//la ilaha illa Allah mohammed rassoul Allah

#include <lua.h>

int luaopen_bismi_allah(lua_State *L)
{
    lua_pushstring(L, "بسم الله الرحمن الرحيم");
    lua_setglobal(L, "bismi_allah");
    lua_pushstring(L, "la ilaha illa Allah mohammed rassoul Allah");
    lua_setglobal(L, "shahada");
    return 0;
}


