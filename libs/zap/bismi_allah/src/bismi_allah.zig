//بسم الله الرحمن الرحيم
//la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const zap = @import("zap");

fn on_request(r: zap.Request) void {
    r.setStatus(.not_found);
    std.debug.print("alamdo li Allah\n\n{any}\n", .{r});
    std.debug.print("method: {s}\n", .{r.method.?});
    std.debug.print("query: {s}\n", .{if (null != r.query) r.query.? else "null"});
    std.debug.print("path: {s}\n\n", .{r.path.?});

    //alhamdo li Allah
    //on error 404
    r.sendBody("<html><head><meta charset=\"utf-8\"></head><body><p>بسم الله الرحمن الرحيم</p><h1>Error: page not found</h1></body></html>") catch return;
}

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    var listener = zap.HttpListener.init(.{
        .port = 3000,
        .on_request = on_request,
        .public_folder = "public",
    });
    try listener.listen();

    zap.start(.{ .threads = 1, .workers = 1 });
}
