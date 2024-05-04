//بسم الله الرحمن الرحيم
//la ilaha illa Allah mohammed rassoul Allah

const print = std.debug.print;
const std = @import("std");
const assert = std.debug.assert;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("بسم الله الرحمن الرحيم\n{s}!\n", .{"la ilaha illa Allah mohammed rassoul Allah"});
    std.debug.print("in the name of Allah\n", .{});
    print("la ilaha illa Allah\n", .{});

    //in the name of Allah
    //integers
    const num1: i32 = 9;
    print("num1 == {}\n", .{num1});

    //float
    const num2: f32 = 7.0 / 3.0;
    print("num2 == {}\n", .{num2});

    //boolean
    print("bools:\n{}\n{}\n{}\n", .{ true, !false, true and false });

    //optional
    var bismi_allah_optional: ?[]const u8 = null;
    assert(bismi_allah_optional == null);
    print("\nbismi_allah_optional\ntype: {}\nvalue: {?s}\n", .{ @TypeOf(bismi_allah_optional), bismi_allah_optional });

    bismi_allah_optional = "bismi_allah";
    //assert(bismi_allah_optional != null);
    print("\nbismi_allah_optional\ntype: {}\nvalue: {?s}\n", .{ @TypeOf(bismi_allah_optional), bismi_allah_optional });

    //loop
    for (3..10) |i| {
        print("i == {}\n", .{i});
    }

    //array
    var bismi_allah_arr = [3]u32{ 0, 7, 14 };
    for (bismi_allah_arr, 0..) |i, j| {
        print("bismi_allah_arr[{}] == {}\n", .{ j, i });
    }
}

test "bismi_allah" {
    for (0..10) |i| {
        _ = i;
        std.debug.print("in the name of Allah\n", .{});
    }
}

test "bismi_allah_for_loop" {
    //comptime var i = 0;
    const bismi_allah_arr = [_]i8{ 10, -12, 12, 13 };
    const bismi_allah_first_neg: ?usize = for (bismi_allah_arr, 0..) |value, i| {
        if (value < 0) break i;
    } else null;
    if (1 == bismi_allah_first_neg) std.debug.print("alhamdo li Allah test passed\n", .{});
}
