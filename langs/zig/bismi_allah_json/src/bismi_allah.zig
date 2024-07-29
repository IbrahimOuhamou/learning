// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");

const BismiAllah = struct {
    id: u32,
    name: []u8,
};

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});
}

test "parse" {
    const allocator = std.testing.allocator;
    var bismi_allah = BismiAllah{ .id = undefined, .name = undefined };
    // std.mem.copyForwards(u8, bismi_allah.name, "bismi Allah");

    const parsed = try std.json.parseFromSlice(
        BismiAllah,
        allocator,
        \\{"id": 5, "name": "bismi Allah"}
    ,
        .{},
    );
    defer parsed.deinit();

    bismi_allah = parsed.value;
    std.debug.print("alhamso li Allah id: {d}\n", .{bismi_allah.id});
    std.debug.print("alhamso li Allah name: {s}\n", .{bismi_allah.name});
}
