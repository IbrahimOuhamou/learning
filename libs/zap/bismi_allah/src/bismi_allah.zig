//بسم الله الرحمن الرحيم
//la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const zap = @import("zap");

fn on_request(r: zap.Request) void {
    r.setStatus(.not_found);
    std.debug.print("alamdo li Allah\n\n{any}\n", .{r});
    std.debug.print("method: {s}\n", .{r.method.?});
    std.debug.print("body: {s}\n", .{if (null != r.body) r.body.? else "null"});
    std.debug.print("query: {s}\n", .{if (null != r.query) r.query.? else "null"});
    std.debug.print("path: {s}\n\n", .{r.path.?});

    //alhamdo li Allah
    //on error 404
    r.sendBody("<html><head><meta charset=\"utf-8\"></head><body><p>بسم الله الرحمن الرحيم</p><h1>Error: page not found</h1></body></html>") catch return;
}

const BismiAllahHandler = struct {
    bismi_allah_visits: i32 = 0,
    alhamdo_li_Allah_visits: i32 = 0,
    pub fn bismiAllah(self: *BismiAllahHandler, r: zap.Request) void {
        _ = self;
        r.sendBody(
            \\<html>
            \\<head>
            \\  <meta charset="utf-8">
            \\  <title>in the name of Allah</title>
            \\  <link href="/bismi_allah.css" rel="text/stylesheet">
            \\</head>
            \\<body>
            \\  <p>بسم الله الرحمن الرحيم</p>
            \\</body>
            \\</html>
        ) catch return;
    }

    pub fn alhamdoLiAllah(self: *BismiAllahHandler, r: zap.Request) void {
        _ = self;
        r.sendBody(
            \\<html>
            \\<head>
            \\  <meta charset="utf-8">
            \\  <title>in the name of Allah</title>
            \\  <link href="/bismi_allah.css" rel="text/stylesheet">
            \\</head>
            \\<body>
            \\  <p>بسم الله الرحمن الرحيم</p>
            \\  <p>الحمد لله</p>
            \\</body>
            \\</html>
        ) catch return;
    }
};

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var bismi_allah_router = zap.Router.init(allocator, .{ .not_found = on_request });
    defer bismi_allah_router.deinit();
    var bismi_allah_handler = BismiAllahHandler{};

    try bismi_allah_router.handle_func("/bismi_allah", &bismi_allah_handler, &BismiAllahHandler.bismiAllah);
    try bismi_allah_router.handle_func("/alhamdo_li_allah", &bismi_allah_handler, &BismiAllahHandler.alhamdoLiAllah);

    var listener = zap.HttpListener.init(.{
        .port = 3000,
        .on_request = bismi_allah_router.on_request_handler(),
        .public_folder = "public",
    });
    try listener.listen();

    zap.start(.{ .threads = 1, .workers = 1 });
}
