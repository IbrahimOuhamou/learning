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

fn bismiAllahWrite(bismi_allah: anytype, stream: anytype) !void {
    _ = try stream.write(std.mem.asBytes(&bismi_allah.bismi_allah1));
    _ = try stream.write(std.mem.asBytes(&bismi_allah.bismi_allah2));
    _ = try stream.write(std.mem.asBytes(&bismi_allah.bismi_allah3));
}

fn bismiAllahRead(bismi_allah: anytype, stream: anytype) !void {
    _ = try stream.read(std.mem.asBytes(&bismi_allah.bismi_allah1));
    _ = try stream.read(std.mem.asBytes(&bismi_allah.bismi_allah2));
    _ = try stream.read(std.mem.asBytes(&bismi_allah.bismi_allah3));
}

test "function with anyopaque with read()/write()" {
    const exepect = std.testing.expect;
    const file = try std.fs.cwd().createFile("bismi_allah.bin", .{ .read = true });
    defer {
        file.close();
        std.fs.cwd().deleteFile("bismi_allah.bin") catch {};
    }

    const BismiAllah = struct {
        bismi_allah1: u32 = 12,
        bismi_allah2: u64 = 12,
        bismi_allah3: f32 = 12.0,
    };
    var bismi_allah = BismiAllah{ .bismi_allah1 = 199, .bismi_allah2 = 299, .bismi_allah3 = 399 };

    try bismiAllahWrite(&bismi_allah, file);

    bismi_allah = .{ .bismi_allah1 = 0, .bismi_allah2 = 0, .bismi_allah3 = 0 };

    try file.seekTo(0);
    try bismiAllahRead(&bismi_allah, file);
    try exepect(bismi_allah.bismi_allah1 == 199);
    try exepect(bismi_allah.bismi_allah2 == 299);
    try exepect(bismi_allah.bismi_allah3 == 399);
}

test "reading after EOF" {
    //const exepect = std.testing.expect;
    const file = try std.fs.cwd().createFile("bismi_allah.bin", .{ .read = true });
    defer {
        file.close();
        std.fs.cwd().deleteFile("bismi_allah.bin") catch {};
    }
    _ = try file.write("la ilaha illa Allah Mohammed Rassoul Allah");
    try file.seekTo(0);
    var buffer: [200]u8 = undefined;
    var bismi_allah: u32 = 0;
    std.debug.print("read bytes {d}\n", .{try file.read(&buffer)});
    std.debug.print("read bytes {d}\n", .{try file.read(&buffer)});
    std.debug.print("read bytes {d}\n", .{try file.read(&buffer)});
    std.debug.print("alhamdo li Allah {s}\n", .{buffer});
    std.debug.print("read bytes {d}\n", .{try file.readAll(&buffer)});
    std.debug.print("read bytes {d}\n", .{try file.readAll(std.mem.asBytes(&bismi_allah))});
}
