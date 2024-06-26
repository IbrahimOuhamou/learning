//بسم الله الرحمن الرحيم
const std = @import("std");
const print = std.debug.print;

var bismi_allah_ctx = false;

const BismiAllah = struct {
    var bismi_allah: u32 = 12;
    pub fn bismi_allah_fn() u32 {
        return 12;
    }
};

pub fn bismi_allah_fn(bismi_allah: BismiAllah) @TypeOf(BismiAllah.bismi_allah) {
    return bismi_allah.bismi_allah;
}

pub inline fn bismi_allah_add_inline(x: u8) u8 {
    return x + 1;
}

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});
    defer std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    var bismi_allah_arr = [_]u3{ 12, -12, 99 };
    bismi_allah_arr[0] = 13;

    print("bismi_allah {}\n", .{BismiAllah.bismi_allah_fn()});
}

test "bismi_allah_add_one" {
    try std.testing.expect(33 == bismi_allah_add_inline(32));
    try std.testing.expect(0 < bismi_allah_add_inline(200));
}

test "bismi_allah_struct_str" {
    const BismiAllah2 = struct { name: [12]u8 = undefined };
    var bismi_allah = BismiAllah2{};
    bismi_allah.name = [12]u8{ 'b', 'i', 's', 'm', 'i', 'A', 'l', 'l', 'a', 'h', '1', '2' };
}
