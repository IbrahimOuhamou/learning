//بسم الله الرحمن الرحيم
//la ilaha illa Allah mohammed rassoul Allah

const std = @import("std");

pub fn main() void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    const bismi_allah_arr: [5]u8 = [_]u8{ 2, 12, 13, 1, 5 };
    var bismi_allah_min: u8 = bismi_allah_arr[0];
    for (bismi_allah_arr) |value| {
        std.debug.print("alhamdo li Allah min:{} value:{}\n", .{ bismi_allah_min, value });
        if (value < bismi_allah_min) {
            bismi_allah_min = value;
        }
    }
    std.debug.print("alhamdo li Allah bismi_allah_min=={}\n", .{bismi_allah_min});
}
