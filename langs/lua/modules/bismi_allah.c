//بسم الله الرحمن الرحيم
//la ilaha illa Allah mohammed rassoul Allah

#include <lua.h>

int bismi_allah(lua_State *L);

int luaopen_bismi_allah(lua_State *L)
{

    lua_newtable(L);
    int bismi_allah_index = lua_gettop(L);

    lua_pushstring(L, "بسم الله الرحمن الرحيم");
    lua_setfield(L, bismi_allah_index, "bismi_allah");
    lua_pushstring(L, "la ilaha illa Allah mohammed rassoul Allah");
    lua_setfield(L, bismi_allah_index, "shahada");

    lua_pushcfunction(L, bismi_allah);
    lua_setglobal(L, "open_bismi_allah");

    return 1;
}


int bismi_allah(lua_State *L)
{
    luaopen_bismi_allah(L);
    lua_setglobal(L, "bismi_allah_module");

    lua_getglobal(L, "bismi_allah_module");
    return 1;

}

