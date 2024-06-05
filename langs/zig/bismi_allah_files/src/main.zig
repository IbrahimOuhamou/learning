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

    _ = try file.write("la ilaha illa Allah Mohammed Rassoul Allah");

    var buffer: [100]u8 = undefined;
    try file.seekTo(0);
    const bytes_read = try file.readAll(&buffer);

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
        try std.testing.expect(bismi_allah.id == 99);
    }
}

test "binary files" {
    const exepect = std.testing.expect;
    const file = try std.fs.cwd().createFile("bismi_allah.bin", .{ .read = true });
    defer {
        file.close();
        std.fs.cwd().deleteFile("bismi_allah.bin") catch {};
    }

    const BismiAllah = struct {
        id: u32 = 12,
        name: [34]u8 = undefined,
        int: u32 = 44,
        float: f32 = 0.13,
    };
    var bismi_allah = BismiAllah{ .id = 99, .name = [_]u8{ 'a', 's', 't', 'a', 'g', 'h', 'f', 'i', 'r', 'o', ' ', 'A', 'l', 'l', 'a', 'h', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ' } };

    _ = try file.write(std.mem.asBytes(&bismi_allah.id));
    _ = try file.write(&bismi_allah.name);
    _ = try file.write(std.mem.asBytes(&bismi_allah.int));
    _ = try file.write(std.mem.asBytes(&bismi_allah.float));

    bismi_allah = .{ .id = 0, .int = 0, .float = 99.99 };
    bismi_allah.name[2] = 'z';

    try file.seekTo(0);
    _ = try file.read(std.mem.asBytes(&bismi_allah.id));
    _ = try file.read(&bismi_allah.name);
    _ = try file.read(std.mem.asBytes(&bismi_allah.int));
    _ = try file.read(std.mem.asBytes(&bismi_allah.float));

    try exepect(bismi_allah.id == 99);
    try exepect(bismi_allah.name[2] == 't');
    try exepect(bismi_allah.int == 44);
    try exepect(bismi_allah.float == 0.13);
}
