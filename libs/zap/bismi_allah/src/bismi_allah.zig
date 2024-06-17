//بسم الله الرحمن الرحيم
//la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const zap = @import("zap");

var allocator: std.mem.Allocator = undefined;

fn simplePage(r: zap.Request, body: []const u8) void {
    const template =
        \\<html>
        \\<head>
        \\  <meta charset="utf-8">
        \\  <title>in the name of Allah</title>
        \\  <link href="/bismi_allah.css" rel="text/stylesheet">
        \\</head>
        \\<body>
        \\  <p>بسم الله الرحمن الرحيم</p>
        \\{s}
        \\</body>
        \\</html>
    ;

    var buffer: [template.len + 1024 * 80]u8 = undefined;
    const filled_buffer = std.fmt.bufPrintZ(&buffer, template, .{body}) catch "Internal Error";
    r.sendBody(filled_buffer) catch return;
}

fn errorPage(r: zap.Request, message: []const u8) void {
    const error_template =
        \\<html>
        \\<head>
        \\  <meta charset="utf-8">
        \\  <title>in the name of Allah</title>
        \\  <link href="/bismi_allah.css" rel="text/stylesheet">
        \\</head>
        \\<body>
        \\  <p>بسم الله الرحمن الرحيم</p>
        \\  <h1 style="color:red">{s}</h1>
        \\</body>
        \\</html>
    ;

    var buffer: [error_template.len + 1024]u8 = undefined;
    const filled_buffer = std.fmt.bufPrintZ(&buffer, error_template, .{message}) catch "Internal Error";
    r.sendBody(filled_buffer) catch return;
}

fn login(r: zap.Request) void {
    r.parseBody() catch {
        r.setStatus(.internal_server_error);
        errorPage(r, "Internal Error");
    };
    r.parseQuery();
    std.debug.print("alhamdo li Allah param count: {d}\n", .{r.getParamCount()});

    std.debug.print("{s}\n", .{r.body orelse ""});
    const account_name = (r.getParamStr(allocator, "input_account_name", false) catch {
        r.setStatus(.forbidden);
        errorPage(r, "Required info were not provided");
        return;
    });
    const account_name_parsed = if (null != account_name) account_name.?.str else "";

    // const account_password = r.getParamSlice("input_account_password") orelse "";
    const account_password = r.getParamStr(allocator, "input_account_password", false) catch {
        r.setStatus(.forbidden);
        errorPage(r, "Required info were not provided");
        return;
    };
    const account_password_parsed = if (null != account_password) account_password.?.str else "";

    std.debug.print("alhamdo li Allah login info was: '{s}' : '{s}'\n", .{ account_name_parsed, account_password_parsed });
    if (std.mem.eql(u8, "bismi_allah", account_name_parsed) and std.mem.eql(u8, "bismi_allah", account_password_parsed)) {
        simplePage(r, "<p>connection info was correct</p>");
    } else {
        errorPage(r, "connection info incorrect");
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
        simplePage(r, "");
    } else {
        //alhamdo li Allah
        //on error 404
        r.setStatus(.not_found);
        errorPage(r, "Error: page not found");
    }
}

fn request_account(r: zap.Request) void {
    if (std.mem.startsWith(u8, r.path.?, "/account/login")) {
        if (null == r.body) {
            // r.sendFile("public/bismi_allah.html") catch errorPage(r, "internal Error");
            simplePage(r,
                \\  <form method="post" action="/account/login">
                \\      <input name="input_account_name" type="text" placeholder="account name"/> <br/>
                \\      <input name="input_account_password" type="password" placeholder="password"/> <br/>
                \\      <button type="submit">login</button> <br/>
                \\ </form>
            );
            return;
        }
        login(r);
    } else {
        simplePage(r, "");
    }
}

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    allocator = gpa.allocator();

    var listener = zap.HttpListener.init(.{
        .port = 3000,
        .on_request = on_request,
        // .public_folder = "public",
    });
    try listener.listen();

    zap.start(.{ .threads = 1, .workers = 1 });
}
