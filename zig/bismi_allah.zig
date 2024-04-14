//بسم الله الرحمن الرحيم
//la ilaha illa Allah mohammed rassoul Allah

const std = @import("std");
const print = @import("std").debug.print;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("بسم الله الرحمن الرحيم\n{s}!\n", .{"la ilaha illa Allah mohammed rassoul Allah"});
    std.debug.print("in the name of Allah\n", .{});
    print("la ilaha illa Allah\n", .{});
}
