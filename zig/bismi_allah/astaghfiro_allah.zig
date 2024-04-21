//بسم الله الرحمن الرحيم
//la ilaha illa Allah mohammed rassoul Allah

const std = @import("std");


pub fn main() void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});
    for (0..100) |i| {
        _ = i;
        std.debug.print("astaghfiro Allah wa atobo ilayh\n", .{});
    }
}


