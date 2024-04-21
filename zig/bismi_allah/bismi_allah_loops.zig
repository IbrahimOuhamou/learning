//بسم الله الرحمن الرحيم
//la ilaha illa Allah mohammed rassoul Allah

const std = @import("std");

pub fn main() void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    const bismi_allah_arr = [_]u8{ 12, 13, 31, 13, 0 };
    for (bismi_allah_arr) |value| {
        if (value == 0) {
            break;
        }
        std.debug.print("alhamdo li Allah\n", .{});
    }
}
