//بسم الله الرحمن الرحيم
//la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const ziglua = @import("ziglua");
const Lua = ziglua.Lua;

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

    try lua.doFile("bismi_allah.lua");
}
