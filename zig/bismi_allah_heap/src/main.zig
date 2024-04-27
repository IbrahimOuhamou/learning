const std = @import("std");

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("in the name of Allah\n", .{});

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    var allocator = arena.allocator();

    const bismi_allah_arr: []u8 = try allocator.alloc(u8, 12);
    for (0..bismi_allah_arr.len) |i| {
        bismi_allah_arr[i] = @intCast(i);
    }

    std.debug.print("{any}\n", .{bismi_allah_arr});
}
