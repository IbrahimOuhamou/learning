// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");

const display_id = 1;
const registry_id = 2;
var next_id: u32 = 3;

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    var general_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = general_allocator.deinit();
    const gpa = general_allocator.allocator();

    const display_path = try getDisplayPath(gpa);
    defer gpa.free(display_path);
    std.debug.print("alhamdo li Allah display_path is: '{s}'\n", .{display_path});

    const socket = try std.net.connectUnixSocket(display_path);
    defer socket.close();

    try socket.writeAll(std.mem.sliceAsBytes(&[_]u32{
        // ID of the object; in this case the default wl_display object at 1
        display_id,

        // The size (in bytes) of the message and the opcode, which is object specific.
        // In this case we are using opcode 1, which corresponds to `wl_display::get_registry`.
        //
        // The size includes the size of the header.
        (0x000C << 16) | (0x0001),

        // Finally, we pass in the only argument that this opcode takes: an id for the `wl_registry`
        // we are creating.
        registry_id,
    }));
}

pub fn getDisplayPath(allocator: std.mem.Allocator) ![]u8 {
    const xdg_runtime_dir_path = try std.process.getEnvVarOwned(allocator, "XDG_RUNTIME_DIR");
    defer allocator.free(xdg_runtime_dir_path);
    const display_name = try std.process.getEnvVarOwned(allocator, "WAYLAND_DISPLAY");
    defer allocator.free(display_name);

    return try std.fs.path.join(allocator, &.{ xdg_runtime_dir_path, display_name });
}
