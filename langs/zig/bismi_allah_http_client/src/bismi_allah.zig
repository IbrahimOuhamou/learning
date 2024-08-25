//بسم الله الرحمن الرحيم
//la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const Client = std.http.Client;
const filepath = "bismi_allah_image.jpeg";

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    const allocator = arena.allocator();

    const uri = try std.Uri.parse("http://localhost:8000/1-scaled.jpg");

    var client = Client{ .allocator = allocator };
    defer client.deinit();

    var server_header_buffer: [2048]u8 = undefined;
    var request = try client.open(.GET, uri, .{ .server_header_buffer = &server_header_buffer });
    defer request.deinit();

    try request.send();
    try request.wait();

    var bismi_allah_buffer = try allocator.alloc(u8, @intCast(request.response.content_length.?));
    const read_size = try request.readAll(bismi_allah_buffer);

    std.debug.print("alamdo li allah content length = '{d}'\n", .{request.response.content_length.?});
    std.debug.print("alamdo li allah read bytes= '{d}'\n", .{read_size});
    std.debug.print("alhamdo li Allah: response '\n{s}\n' \n", .{bismi_allah_buffer[0..read_size]});
}
