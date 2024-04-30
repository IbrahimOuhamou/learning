const std = @import("std");

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("in the name of Allah\n", .{});

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    var allocator = arena.allocator();

    var bismi_allah_arr: []u8 = try allocator.alloc(u8, 12);
    defer allocator.free(bismi_allah_arr);
    for (0..bismi_allah_arr.len) |i| {
        bismi_allah_arr[i] = @intCast(i);
    }
    std.debug.print("alhamdo li Allah arr is now: [{d}]{any}\n", .{ bismi_allah_return_arr_size(bismi_allah_arr), bismi_allah_arr });
    defer std.debug.print("alhamdo li Allah defer is now: [{d}]{any}\n", .{ bismi_allah_arr.len, bismi_allah_arr });

    bismi_allah_arr = try allocator.alloc(u8, 99);
    defer allocator.free(bismi_allah_arr);
    for (0..bismi_allah_arr.len) |i| {
        bismi_allah_arr[i] = @intCast(i);
    }
}

fn bismi_allah_return_arr_size(arr: []u8) usize {
    return arr.len;
}
