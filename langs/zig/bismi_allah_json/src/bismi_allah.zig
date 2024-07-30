// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});
}

test "parse" {
    const BismiAllah = struct {
        id: u32,
        name: []u8,
    };

    const allocator = std.testing.allocator;
    var bismi_allah = BismiAllah{ .id = undefined, .name = undefined };
    // std.mem.copyForwards(u8, bismi_allah.name, "bismi Allah");

    const parsed = try std.json.parseFromSlice(
        BismiAllah,
        allocator,
        \\{ "id": 5, "name": "bismi Allah" }
    ,
        .{},
    );
    defer parsed.deinit();

    bismi_allah = parsed.value;
    // std.debug.print("alhamso li Allah id: {d}\n", .{bismi_allah.id});
    // std.debug.print("alhamso li Allah name: {s}\n", .{bismi_allah.name});
}

test "parse low level" {
    const BismiAllah = struct {
        id: u32,
        name: [34]u8,
    };

    const allocator = std.testing.allocator;
    var bismi_allah = BismiAllah{ .id = undefined, .name = undefined };
    // std.mem.copyForwards(u8, bismi_allah.name, "bismi Allah");

    var scanner = std.json.Scanner.initStreaming(allocator);
    defer scanner.deinit();
    scanner.feedInput(
        \\{
        \\  "id": 5,
        \\  "name" : "bismi Allah",
        \\}
    );
    scanner.endInput();

    while (scanner.next()) |token| {
        std.debug.print("alhamdo li Allah token: '{any}'\n", .{token});

        switch (token) {
            .end_of_document => break,
            .number => bismi_allah.id = try std.fmt.parseInt(u32, token.number, 10),
            else => {},
        }
    } else |err| {
        std.debug.print("alhamdo li Allah error {any}\n", .{err});
    }

    std.debug.print("alhamso li Allah id: {d}\n", .{bismi_allah.id});
    std.debug.print("alhamso li Allah name: {s}\n", .{bismi_allah.name});
}

test "bismi Allah stringify" {
    const BismiAllah = struct {
        id: u32,
        name: [34]u8,
    };

    var bismi_allah = BismiAllah{ .id = 7, .name = undefined };
    std.mem.copyForwards(u8, &bismi_allah.name, "la ilaha illa Allah");
    var bismi_allah2 = BismiAllah{ .id = 9, .name = undefined };
    std.mem.copyForwards(u8, &bismi_allah2.name, "astaghfiro Allah");

    var bismi_allah_buffer: [512 * 4]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&bismi_allah_buffer);
    var string = std.ArrayList(u8).init(fba.allocator());
    std.json.stringify(bismi_allah, .{ .escape_unicode = true, .whitespace = .indent_4 }, string.writer()) catch |err| {
        std.debug.print("alhamdo li Allah err: '{any}'\n", .{err});
    };
    _ = try string.writer().write(",");
    std.json.stringify(bismi_allah2, .{ .escape_unicode = true, .whitespace = .indent_4 }, string.writer()) catch |err| {
        std.debug.print("alhamdo li Allah err: '{any}'\n", .{err});
    };

    std.debug.print("alhamdo li Allah value: '{s}'\n", .{string.items});
}
