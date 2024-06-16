//بسم الله الرحمن الرحيم
//la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const zap = @import("zap");

var allocator: std.mem.Allocator = undefined;

fn error_page(r: zap.Request) void {
    r.setStatus(.internal_server_error);
    r.sendBody(
        \\<html>
        \\<head>
        \\  <meta charset="utf-8">
        \\  <title>in the name of Allah</title>
        \\  <link href="/bismi_allah.css" rel="text/stylesheet">
        \\</head>
        \\<body>
        \\  <p>بسم الله الرحمن الرحيم</p>
        \\ <p style="color:red">Internal error</p>
        \\</body>
        \\</html>
    ) catch return;
}

fn login(r: zap.Request) void {
    r.parseBody() catch error_page(r);
    r.parseQuery();
    std.debug.print("alhamdo li Allah param count: {d}\n", .{r.getParamCount()});
    // const params = r.parametersToOwnedList(allocator, false) catch unreachable;
    // defer params.deinit();
    // std.debug.print("alhamdo li Allah params: {any}\n", .{params.items});

    // for (params.items) |kv| {
    //     if (kv.value) |v| {
    //         std.debug.print("param '{s}' in owned list is '{s}'\n", .{ kv.key.str, v.String.str });
    //     }
    // }

    std.debug.print("{s}\n", .{r.body orelse ""});
    const account_name = (r.getParamStr(allocator, "input_account_name", false) catch {
        error_page(r);
        return;
    });
    const account_name_parsed = if (null != account_name) account_name.?.str else "";

    // const account_password = r.getParamSlice("input_account_password") orelse "";
    const account_password = r.getParamStr(allocator, "input_account_password", false) catch {
        error_page(r);
        return;
    };
    const account_password_parsed = if (null != account_password) account_password.?.str else "";

    std.debug.print("alhamdo li Allah login info was: '{s}' : '{s}'\n", .{ account_name_parsed, account_password_parsed });
    if (std.mem.eql(u8, "bismi_allah", account_name_parsed) and std.mem.eql(u8, "bismi_allah", account_password_parsed)) {
        r.sendBody(
            \\<html>
            \\<head>
            \\  <meta charset="utf-8">
            \\  <title>in the name of Allah</title>
            \\  <link href="/bismi_allah.css" rel="text/stylesheet">
            \\</head>
            \\<body>
            \\  <p>بسم الله الرحمن الرحيم</p>
            \\  <p>connection info was correct</p>
            \\</body>
            \\</html>
        ) catch return;
    } else {
        r.sendBody(
            \\<html>
            \\<head>
            \\  <meta charset="utf-8">
            \\  <title>in the name of Allah</title>
            \\  <link href="/bismi_allah.css" rel="text/stylesheet">
            \\</head>
            \\<body>
            \\  <p>بسم الله الرحمن الرحيم</p>
            \\  <p style="color:red;">connection info incorrect</p>
            \\</body>
            \\</html>
        ) catch return;
    }
}

fn on_request(r: zap.Request) void {
    std.debug.print("===========================================================================\n", .{});
    defer std.debug.print("===========================================================================\n", .{});

    std.debug.print("alhamdo li Allah\n", .{});
    std.debug.print("{any}\n", .{r});
    std.debug.print("method: {s}\n", .{r.method orelse "null"});
    std.debug.print("body: {s}\n", .{r.body orelse "null"});
    std.debug.print("query: {s}\n", .{r.query orelse "null"});
    std.debug.print("path: {s}\n\n", .{r.path orelse "null"});

    if (std.mem.startsWith(u8, r.path.?, "/account")) {
        request_account(r);
    } else if (std.mem.startsWith(u8, r.path.?, "/bismi_allah")) {
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
    } else {
        //alhamdo li Allah
        //on error 404
        r.setStatus(.not_found);
        r.sendBody("<html><head><meta charset=\"utf-8\"></head><body><p>بسم الله الرحمن الرحيم</p><h1>Error: page not found</h1></body></html>") catch return;
    }
}

fn request_account(r: zap.Request) void {
    if (std.mem.startsWith(u8, "/account/login", r.path.?)) {
        if (null == r.body) {
            r.sendBody(
                \\<html>
                \\<head>
                \\  <meta charset="utf-8">
                \\  <title>in the name of Allah</title>
                \\  <link href="/bismi_allah.css" rel="text/stylesheet">
                \\</head>
                \\  <body>
                \\      <p>بسم الله الرحمن الرحيم</p>
                \\      <form method="post" action="/account/login">
                \\      <input name="input_account_name" type="text" placeholder="account name"/> <br/>
                \\      <input name="input_account_password" type="password" placeholder="password"/> <br/>
                \\      <button type="submit">login</button> <br/>
                \\  </form>
                \\</body>
                \\</html>
            ) catch return;
            return;
        }
        login(r);
    } else {
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
}

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    allocator = gpa.allocator();

    var listener = zap.HttpListener.init(.{
        .port = 3000,
        // .on_request = bismi_allah_router.on_request_handler(),
        .on_request = on_request,
        // .public_folder = "public",
    });
    try listener.listen();

    zap.start(.{ .threads = 1, .workers = 1 });
}
