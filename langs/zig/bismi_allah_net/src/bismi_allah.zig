//بسم الله الرحمن الرحيم
//la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const net = std.net;

const addr = net.Address.initIp4(.{ 127, 0, 0, 1 }, 4000);

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    var bismi_allah_buffer: [1024]u8 = undefined;

    std.debug.print("alhamdo li Allah port: {d}\n", .{addr.getPort()});

    var server = try addr.listen(.{ .reuse_port = true });
    defer server.deinit();

    while (true) {
        const client = try server.accept();
        defer client.stream.close();
        std.debug.print("alhamdo li Allah: client addr: '{any}', client stream: '{any}'\n", .{ client.address, client.stream });

        const bytes_read = try client.stream.read(&bismi_allah_buffer);
        std.debug.print("alahmdo li Allah read {d} bytes\n", .{bytes_read});
        std.debug.print("alahmdo li Allah recieved:\n{s}\n", .{bismi_allah_buffer[0..bytes_read]});
    }
}
