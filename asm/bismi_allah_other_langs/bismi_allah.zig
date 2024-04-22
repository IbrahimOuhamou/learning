//بسم الله الرحمن الرحيم
//la ilaha illa Allah mohammed rassoul Allah

const std = @import("std");

pub fn main() void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    var bismi_allah_var = bismi_allah();
    bismi_allah_ref(&bismi_allah_var);
    var bismi_allah_arr: [5]u8 = [5]u8{ 1, 2, 3, 4, 5 };
    bismi_allah_var = bismi_allah_for(bismi_allah_arr);
    std.debug.print("bismi_allah_var == {}\n", .{bismi_allah_var});
}

fn bismi_allah() u32 {
    return 12;
}

fn bismi_allah_ref(bismi_allah_var: *u32) void {
    bismi_allah_var.* = 0;
}

fn bismi_allah_for(bismi_allah_arr: [5]u8) u32 {
    var bismi_allah_var: u32 = 0;
    for (bismi_allah_arr) |value| {
        bismi_allah_var += value;
    }
    return bismi_allah_var;
}
