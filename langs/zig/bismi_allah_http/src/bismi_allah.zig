//بسم الله الرحمن الرحيم
//la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const net = std.net;

const addr = net.Address.initIp4(.{ 127, 0, 0, 1 }, 4000);
const html_page = @embedFile("bismi_allah.html");

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    var bismi_allah_buffer: [1024]u8 = undefined;

    std.debug.print("alhamdo li Allah port: {d}\n", .{addr.getPort()});

    var server = try addr.listen(.{ .reuse_port = true });
    defer server.deinit();

    accept: while (true) {
        const client = try server.accept();
        defer client.stream.close();
        std.debug.print("alhamdo li Allah: client addr: '{any}', client stream: '{any}'\n", .{ client.address, client.stream });

        var http_server = std.http.Server.init(client, &bismi_allah_buffer);
        while (http_server.state == .ready) {
            var request = http_server.receiveHead() catch |err| {
                std.debug.print("error: {s}\n", .{@errorName(err)});
                continue :accept;
            };

            try request.respond(html_page, .{
                .status = .ok,
                .extra_headers = &.{
                    .{ .name = "Content-Type", .value = "text/html; charset=utf-8" },
                },
            });
        }

        const bytes_read = try client.stream.read(&bismi_allah_buffer);
        std.debug.print("alahmdo li Allah read {d} bytes\n", .{bytes_read});
        std.debug.print("alahmdo li Allah recieved:\n{s}\n", .{bismi_allah_buffer[0..bytes_read]});
    }
}
