// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");

var bismi_allah_buffer: [512]u8 = undefined;

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    var fba = std.heap.FixedBufferAllocator.init(&bismi_allah_buffer);
    var allocator = fba.allocator();

    const app_dir_data_path = try std.fs.getAppDataDir(allocator, "bismi_allah_app");
    defer allocator.free(app_dir_data_path);

    std.debug.print("alhamdo li Allah app_dir_data: '{s}'\n", .{app_dir_data_path});

    std.fs.makeDirAbsolute(app_dir_data_path) catch |e| switch (e) {
        std.fs.Dir.MakeError.PathAlreadyExists => {},
        else => return e,
    };

    var app_dir_data = try std.fs.openDirAbsolute(app_dir_data_path, .{});
    app_dir_data.close();
}
