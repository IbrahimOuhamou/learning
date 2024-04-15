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
}
