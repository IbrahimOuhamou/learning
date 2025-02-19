// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const builtin = @import("builtin");

const bismi_allah = enum {
    bismi_allah,
};

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    const typeinfo = @typeInfo(bismi_allah);
    _ = typeinfo;
}
