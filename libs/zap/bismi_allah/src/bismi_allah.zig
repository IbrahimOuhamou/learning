//بسم الله الرحمن الرحيم
//la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const zap = @import("zap");

var allocator: std.mem.Allocator = undefined;

var accounts: std.AutoHashMap([64]u8, [64]u8) = undefined;

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

fn onRequest(r: zap.Request) void {
    std.debug.print("===========================================================================\n", .{});
    defer std.debug.print("===========================================================================\n", .{});

    std.debug.print("alhamdo li Allah\n", .{});
    std.debug.print("{any}\n", .{r});
    std.debug.print("method: {s}\n", .{r.method orelse "null"});
    std.debug.print("body: {s}\n", .{r.body orelse "null"});
    std.debug.print("query: {s}\n", .{r.query orelse "null"});
    std.debug.print("path: {s}\n\n", .{r.path orelse "null"});

    if (std.mem.startsWith(u8, r.path.?, "/account")) {
        requestAccount(r);
    } else if (std.mem.startsWith(u8, r.path.?, "/bismi_allah")) {
        simplePage(r, "");
    } else {
        //alhamdo li Allah
        //on error 404
        r.setStatus(.not_found);
        errorPage(r, "Error: page not found");
    }
}

fn requestAccount(r: zap.Request) void {
    if (std.mem.eql(u8, r.path.?, "/account/login")) {
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
    } else if (std.mem.eql(u8, r.path.?, "/account/register")) {
        if (null == r.body) {
            simplePage(r,
                \\  <form method="post" action="/account/register">
                \\      <input name="input_account_name" type="text" placeholder="account name"  maxlength="64"/> <br/>
                \\      <input name="input_account_password" type="password" placeholder="password"  maxlength="64"/> <br/>
                \\      <button type="submit">login</button> <br/>
                \\ </form>
            );
            return;
        }
        register(r);
    } else {
        simplePage(r, "");
    }
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
        r.setStatus(.bad_request);
        errorPage(r, "Required info were not provided");
        return;
    });
    const account_name_parsed = if (null != account_name) account_name.?.str else "";

    // const account_password = r.getParamSlice("input_account_password") orelse "";
    const account_password = r.getParamStr(allocator, "input_account_password", false) catch {
        r.setStatus(.bad_request);
        errorPage(r, "Required info were not provided");
        return;
    };
    const account_password_parsed = if (null != account_password) account_password.?.str else "";

    var account_name_buffer: [64]u8 = undefined;
    var account_password_buffer: [64]u8 = undefined;

    {
        var i: usize = 0;
        while (i < account_name_buffer.len) : (i += 1) account_name_buffer[i] = 0;

        i = 0;
        while (i < account_password_buffer.len) : (i += 1) account_password_buffer[i] = 0;
    }

    std.mem.copyForwards(u8, &account_name_buffer, account_name_parsed);
    std.mem.copyForwards(u8, &account_password_buffer, account_password_parsed);

    if (accounts.get(account_name_buffer)) |real_account_password| {
        if (std.mem.eql(u8, &real_account_password, &account_password_buffer)) {
            simplePage(r, "<p>connection info were correct</p>");
        } else {
            errorPage(r, "connection info incorrect");
        }
    } else {
        errorPage(r, "connection info incorrect");
    }

    std.debug.print("alhamdo li Allah login info buffer were: '{s}' : '{s}'\n", .{ account_name_buffer, account_password_buffer });
}

fn register(r: zap.Request) void {
    r.parseBody() catch {
        r.setStatus(.internal_server_error);
        errorPage(r, "Internal Error");
    };
    r.parseQuery();
    std.debug.print("alhamdo li Allah param count: {d}\n", .{r.getParamCount()});

    const account_name = (r.getParamStr(allocator, "input_account_name", false) catch {
        r.setStatus(.bad_request);
        errorPage(r, "Required info were not provided");
        return;
    });
    const account_name_parsed = if (null != account_name) account_name.?.str else "";

    const account_password = r.getParamStr(allocator, "input_account_password", false) catch {
        r.setStatus(.bad_request);
        errorPage(r, "Required info were not provided");
        return;
    };
    const account_password_parsed = if (null != account_password) account_password.?.str else "";
}

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    allocator = gpa.allocator();

    accounts = std.AutoHashMap([64]u8, [64]u8).init(allocator);
    defer accounts.deinit();
    {
        var buffer_name: [64]u8 = undefined;
        var buffer_password: [64]u8 = undefined;

        {
            var i: usize = 0;
            while (i < buffer_name.len) : (i += 1) buffer_name[i] = 0;

            i = 0;
            while (i < buffer_password.len) : (i += 1) buffer_password[i] = 0;
        }

        std.mem.copyForwards(u8, &buffer_name, "bismi_allah");
        std.mem.copyForwards(u8, &buffer_password, "bismi_allah");
        try accounts.put(buffer_name, buffer_password);

        var password = accounts.get(buffer_name);
        if (!std.mem.eql(u8, &buffer_password, &password.?)) {
            unreachable;
        }

        if (accounts.get(buffer_name)) |real_password| {
            if (!std.mem.eql(u8, &buffer_password, &real_password)) {
                unreachable;
            }
        }

        {
            var i: usize = 0;
            while (i < buffer_name.len) : (i += 1) buffer_name[i] = 0;

            i = 0;
            while (i < buffer_password.len) : (i += 1) buffer_password[i] = 0;
        }

        std.mem.copyForwards(u8, &buffer_name, "alhamdo_li_allah");
        std.mem.copyForwards(u8, &buffer_password, "alhamdo_li_allah");
        try accounts.put(buffer_name, buffer_password);

        password = accounts.get(buffer_name);
        std.debug.print("alahdmo li Allah name is: '{any}'\n", .{password.?});
    }

    var listener = zap.HttpListener.init(.{
        .port = 3000,
        .on_request = onRequest,
        // .public_folder = "public",
    });
    try listener.listen();

    zap.start(.{ .threads = 1, .workers = 1 });
}
