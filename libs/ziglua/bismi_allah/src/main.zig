//بسم الله الرحمن الرحيم
//la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const ziglua = @import("ziglua");
const Lua = ziglua.Lua;

pub fn sayBismiAllah(lua: *Lua) i32 {
    _ = lua;
    std.debug.print("in the name of Allah\n", .{});
    return 0;
}

pub fn bismiAllahIndex(lua: *Lua) i32 {
    _ = lua;
    return 1;
}

pub fn bismiAllahModule(lua: *Lua) i32 {
    lua.newTable();

    lua.pushInteger(7);
    lua.setField(-2, "bismi_allah_number");

    return 1;
}

const BismiAllah = struct {
    id: u32 = 0,
};

pub export fn luaopen_bismi_allah_module(lua: *Lua) i32 {
    return bismiAllahModule(lua);
}

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    var lua = try Lua.init(&allocator);
    defer lua.deinit();

    lua.openLibs();

    _ = lua.pushString("بسم الله الرحمن الرحيم\n");
    lua.setGlobal("basmala");

    lua.pushFunction(ziglua.wrap(sayBismiAllah));
    lua.setGlobal("sayBismiAllah");

    if (lua.getGlobal("basmala")) |basmala_type| {
        switch (basmala_type) {
            ziglua.LuaType.string => std.debug.print("[C] alhamdo li Allah basmala is a string\n", .{}),
            inline else => {},
        }
    } else |e| {
        std.debug.print("error: {any}\n", .{e});
    }
    const basmala_index = lua.getTop();

    // bismi Allah
    // will try
    // metatables
    lua.newTable();
    lua.pushFunction(ziglua.wrap(bismiAllahIndex));
    lua.setField(-2, "__index");
    lua.setMetatable(basmala_index);

    var bismi_allah = BismiAllah{ .id = 99 };
    lua.pushLightUserdata(&bismi_allah);
    lua.setGlobal("bismi_allah");

    //_ = ziglua.exportFn("bismi_allah_module", bismiAllahModule);

    try lua.doFile("bismi_allah.lua");
}
