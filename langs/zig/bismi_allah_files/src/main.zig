//بسم الله الرحمن الرحيم
//la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");

pub fn main() !void {
    std.debug.print("in the name of Allah\n", .{});
}

test "simple file" {
    const file = try std.fs.cwd().createFile("bismi_allah.bin", .{ .read = true });
    defer {
        file.close();
        std.fs.cwd().deleteFile("bismi_allah.bin") catch {};
    }

    const bytes_written = try file.write("la ilaha illa Allah Mohammed Rassoul Allah");
    std.debug.print("alhamdo li Allah wrote {d} bytes\n", .{bytes_written});

    var buffer: [100]u8 = undefined;
    try file.seekTo(0);
    const bytes_read = try file.readAll(&buffer);

    std.debug.print("alhamdo li Allah read {d} bytes\n", .{bytes_read});
    try std.testing.expect(std.mem.eql(u8, buffer[0..bytes_read], "la ilaha illa Allah Mohammed Rassoul Allah"));

    {
        const BismiAllah = struct {
            id: u32 = 12,
            name: [34]u8 = undefined,
        };
        var bismi_allah = BismiAllah{ .id = 99, .name = [_]u8{ 'a', 's', 't', 'a', 'g', 'h', 'f', 'i', 'r', 'o', ' ', 'A', 'l', 'l', 'a', 'h', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' } };
        try file.seekTo(0);
        _ = try file.writeAll(std.mem.asBytes(&bismi_allah.id));
        bismi_allah.id = 8;
        try file.seekTo(0);
        _ = try file.read(std.mem.asBytes(&bismi_allah.id));
        std.debug.print("alhamdo li Allah bismi_allah.id == {d}\n", .{bismi_allah.id});

        try file.seekTo(0);
        const bit: u8 = 1;

        var bit_buffer: @TypeOf(bit) = 0;
        bit_buffer = bit;
        std.mem.reverse(u8, std.mem.asBytes(&bit_buffer));

        _ = try file.write(std.mem.asBytes(&bit_buffer));
        std.debug.print("alhamdo li Allah bit == {d} | bit_buffer == {d}\n", .{ bit, bit_buffer });
    }
}
