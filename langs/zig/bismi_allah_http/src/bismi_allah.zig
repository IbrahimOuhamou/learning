//بسم الله الرحمن الرحيم
//la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");

pub fn main() !void {
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();
    try stdout.print("بسم الله الرحمن الرحيم\n", .{});
    try bw.flush();

    const page_allocator = std.heap.page_allocator;

    const bismi_allah_buffer = try page_allocator.alloc(u8, 4096);

    const connection = try std.net.Server.accept();
    defer connection.stream.close();

    var server = std.http.Server.init(connection, bismi_allah_buffer);

    while (.ready == server.state) {
        // var request
        _ = server.receiveHead() catch |err| {
            std.debug.print("alhamdo li Allah error: {s}\n", .{@errorName(err)});
            unreachable;
        };
    }

    try server.receiveHead();
    try stdout.print("alhamdo li Allah recieved:\n{any}\n", server.read_buffer);
}
