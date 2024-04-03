//in the name of Allah
//la ilaha illa Allah mohammed rassoul Allah


#include <stdio.h>
#include <stdlib.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

int bismi_allah_func(lua_State *L)
{
    printf("[c] alhamdo li Allah called bismi_allah_func()");
    return 0;
}

int main()
{
    printf("in the name of Allah\n");

    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    /*
    luaL_dostring(L, "bismi_allah_table={12, 13}");
    lua_getglobal(L, "bismi_allah_table");
    lua_pushstring(L, "bismi_allah");
    lua_pushnumber(L, 9);
    lua_settable(L, -3);
    luaL_dostring(L, "print(\"[lua] assalmo alaykom\")");
    luaL_dostring(L, "print(\"[lua] assalmo alaykom \" .. bismi_allah_table['bismi_allah'])");
    */

    /*
    lua_pushstring(L, "la ilaha illa Allah");
    lua_setglobal(L, "bismi_allah");
    luaL_dostring(L, "print(\"[luac]bismi_allah = \" .. bismi_allah)");
    */

    lua_newtable(L);
    
    lua_pushnumber(L, 12);
    lua_pushstring(L, "alhamdo li Allah");
    lua_settable(L, -3);

    lua_pushcfunction(L, bismi_allah_func);
    lua_setfield(L, -2, "bismi_allah_func");

    lua_setglobal(L, "bismi_allah_table");

    lua_getglobal(L, "bismi_allah_table");
    if(lua_istable(L, -1))
    {
        printf("[c] alhamdo li Allah 'bismi_allah_table' is a table\n");
    }
    else
    {
        printf("[c] alhamdo li Allah 'bismi_allah_table' is not a table\n");
    }

    lua_pushstring(L, "la ilaha illa Allah mohammed rassoul Allah");
    lua_setglobal(L, "bismi_allah_undefined");

    lua_getglobal(L, "bismi_allah_undefined");
    if(lua_istable(L, -1))
    {
        printf("[c] alhamdo li Allah 'bismi_allah_undefined' is a table\n");
    }
    else if(lua_isnil(L, -1))
    {
        printf("[c] alhamdo li Allah 'bismi_allah_undefined' is not defined\n");
    }
    else if(lua_isnone(L, -1))
    {
        printf("[c] alhamdo li Allah 'bismi_allah_undefined' is none\n");
    }
    else
    {
        printf("[c] alhamdo li Allah 'bismi_allah_undefined' is not a table\n");
    }
    lua_pop(L, 1);
    if(lua_isnil(L, -1))
    {
        printf("[c] alhamdo li Allah top of the stack is not defined\n");
    }

    luaL_dofile(L, "bismi_allah.lua");
}

