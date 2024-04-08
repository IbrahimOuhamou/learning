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

    lua_newtable(L);
    int bismi_allah_table_index = lua_gettop(L);
    lua_pushstring(L, "bismi Allah");
    lua_setfield(L, bismi_allah_table_index, "bismi_allah");
    lua_pushstring(L, "Allah Akbar");
    lua_setfield(L, bismi_allah_table_index, "Allah Akbar");
    
    lua_pushnil(L);
    while(0 != lua_next(L, -2))
    {
        printf("table[%s] == %s\n", lua_tostring(L, -2), lua_tostring(L, -1));
        lua_pop(L, 1);
    }

}

