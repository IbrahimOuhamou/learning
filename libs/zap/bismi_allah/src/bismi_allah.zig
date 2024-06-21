//بسم الله الرحمن الرحيم
//la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const zap = @import("zap");
const uuid = @import("uuid-zig");

const Error = error{
    bismi_allah,
};

const Session = struct {
    values: std.StringHashMap([512]u8),
};

var allocator: std.mem.Allocator = undefined;

var accounts: std.AutoHashMap([64]u8, [64]u8) = undefined;
var sessions: std.AutoHashMap(uuid.urn.Urn, *Session) = undefined;

fn isSessionSet(r: zap.Request) bool {
    r.parseCookies(false);

    if (null != r.getCookieStr(allocator, "session_id", false) catch null) return true;
    return false;
}

fn getSession(r: zap.Request) ?*Session {
    if (!isSessionSet(r)) return null;

    const session_uuid: *const uuid.urn.Urn = if (r.getCookieStr(allocator, "session_id", false) catch null) |maybe_session_uuid| maybe_session_uuid.str[0..36] else &[_]u8{0} ** 36;

    if (std.mem.eql(u8, session_uuid, &[_]u8{0} ** 36)) {
        std.debug.print("alhamdo li Allah: Error while getting the session uuid\n", .{});
        return null;
    }
    std.debug.print("alhamdo li Allah got session uuid '{s}'\n", .{session_uuid});

    if (sessions.get(session_uuid.*)) |session| {
        return session;
    } else {
        r.setCookie(.{
            .name = "session_id",
            .value = &session_uuid.*,
            .path = "/",
            .max_age_s = 60 * 60 * 24,
            .domain = null,
            .secure = true,
            .http_only = false,
        }) catch |e| {
            std.debug.print("alhamdo li Allah ERROR: cannot set Cookie {any}\n", .{e});
            return null;
        };
        const session = allocator.create(Session) catch {
            std.debug.print("alhamdo li Allah error while creating session object\n", .{});
            r.setStatus(.not_found);
            errorPage(r, "Internal Error");
            return null;
        };
        session.* = Session{ .values = std.StringHashMap([512]u8).init(allocator) };

        sessions.put(session_uuid.*, session) catch {
            r.setStatus(.internal_server_error);
            errorPage(r, "internal Error");
            std.debug.print("alhamdo li Allah: Error creating session 'putting it in sessions StringHashMap'\n", .{});
            return null;
        };
        return getSession(r);
    }
}

fn startSession(r: zap.Request) Error!void {
    if (isSessionSet(r)) return;

    const session_id = uuid.v7.new();
    const session_uuid = uuid.urn.serialize(session_id);
    r.parseCookies(false);

    r.setCookie(.{
        .name = "session_id",
        .value = &session_uuid,
        .path = "/",
        .max_age_s = 60 * 60 * 24,
        .domain = null,
        .secure = true,
        .http_only = false,
    }) catch |e| {
        std.debug.print("alhamdo li Allah ERROR: cannot set Cookie {any}\n", .{e});
        return Error.bismi_allah;
    };

    const session = allocator.create(Session) catch {
        std.debug.print("alhamdo li Allah error while creating session object\n", .{});
        r.setStatus(.not_found);
        errorPage(r, "Internal Error");
        return;
    };
    session.* = Session{ .values = std.StringHashMap([512]u8).init(allocator) };

    sessions.put(session_uuid, session) catch {
        r.setStatus(.internal_server_error);
        errorPage(r, "internal Error");
        std.debug.print("alhamdo li Allah: Error creating session 'putting it in sessions StringHashMap'\n", .{});
        return;
    };
}

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
    const filled_buffer = std.fmt.bufPrint(&buffer, template, .{body}) catch "Internal Error";
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
    const filled_buffer = std.fmt.bufPrint(&buffer, error_template, .{message}) catch "Internal Error";
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

    startSession(r) catch {
        std.debug.print("alhamdo li Allah Error while starting session\n", .{});
    };

    std.debug.print("alhamdo li Allah there are {d} cookies\n", .{r.getCookiesCount()});
    // iterate over all cookies as strings (always_alloc=false)
    var strCookies = r.cookiesToOwnedStrList(allocator, false) catch unreachable;
    defer strCookies.deinit();
    std.debug.print("\n", .{});
    for (strCookies.items) |kv| {
        std.log.info("CookieStr `{s}` is `{s}`", .{ kv.key.str, kv.value.str });
        // we don't need to deinit kv.key and kv.value because we requested always_alloc=false
        // so they are just slices into the request buffer
    }

    if (std.mem.startsWith(u8, r.path.?, "/account")) {
        requestAccount(r);
    } else if (std.mem.startsWith(u8, r.path.?, "/bismi_allah")) {
        simplePage(r, "");
    } else {
        //alhamdo li Allah
        //on error 404
        r.setStatus(.not_found);
        errorPage(r, "Error 404: page not found");
    }
}

fn requestAccount(r: zap.Request) void {
    if (null == r.path) return;
    if (std.mem.eql(u8, r.path.?, "/account") or std.mem.eql(u8, r.path.?, "/account/")) {
        if (getSession(r)) |session| {
            std.debug.print("account_name '{s}'\n", .{session.values.get("account_name") orelse [_]u8{0} ** 512});
            if (session.values.get("account_name")) |account_name| {
                // const body_template = "<p>assalamo alaykom <b>{s}</b></p>";
                const body_template = "assalamo alaykom {s}";
                var body_buffer: [body_template.len + 512]u8 = undefined;

                const filled_buffer = std.fmt.bufPrint(&body_buffer, body_template, .{account_name}) catch |e| {
                    errorPage(r, "Internal Error");
                    r.setStatus(.internal_server_error);
                    std.debug.print("alhamdo li Allah Error: {s}\n", .{@errorName(e)});
                    return;
                };

                std.debug.print("filled body buffer: '{s}'\n", .{filled_buffer});
                simplePage(r, filled_buffer);
            } else {
                simplePage(r, "<p>asslamo alaykom user, please consider <a href=\"/account/login\">logging in</a> or <a href=\"/account/register\">register</a> if you don't have an account </p>");
            }
        } else {
            r.setStatus(.internal_server_error);
            errorPage(r, "internal Error");
            std.debug.print("alhamdo li Allah: Error while getting the session\n", .{});
            return;
        }
    } else if (std.mem.eql(u8, r.path.?, "/account/login")) {
        if (null == r.body) {
            simplePage(r,
                \\  <form method="post" action="/account/login">
                \\      <input name="input_account_name" type="text" placeholder="account name"/> <br/>
                \\      <input name="input_account_password" type="password" placeholder="password"/> <br/>
                \\      <button type="submit">login</button> <br/>
                \\  </form>
            );
        } else {
            login(r);
        }
    } else if (std.mem.eql(u8, r.path.?, "/account/register")) {
        if (null == r.body) {
            simplePage(r,
                \\  <form method="post" action="/account/register">
                \\      <input name="input_account_name" type="text" placeholder="account name"  maxlength="64"/> <br/>
                \\      <input name="input_account_password" type="password" placeholder="password"  maxlength="64"/> <br/>
                \\      <button type="submit">login</button> <br/>
                \\  </form>
            );
        } else {
            register(r);
        }
    } else {
        r.setStatus(.not_found);
        errorPage(r, "Error 404: Page not found");
    }
}

fn login(r: zap.Request) void {
    r.parseBody() catch {
        r.setStatus(.internal_server_error);
        errorPage(r, "Internal Error");
        return;
    };
    r.parseQuery();

    // std.debug.print("alhamdo li Allah param count: {d}\n", .{r.getParamCount()});

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

    var account_name_buffer: [64]u8 = [_]u8{0} ** 64;
    var account_password_buffer: [64]u8 = [_]u8{0} ** 64;

    std.mem.copyForwards(u8, &account_name_buffer, account_name_parsed);
    std.mem.copyForwards(u8, &account_password_buffer, account_password_parsed);

    if (accounts.get(account_name_buffer)) |real_account_password| {
        if (std.mem.eql(u8, &real_account_password, &account_password_buffer)) {

            // alhamdo li Allah fixed the bug of 'r.setCookie()' being called after request
            var session = getSession(r);
            if (null != session) {
                var account_name_buffer_for_hashmap_value: [512]u8 = [_]u8{0} ** 512;

                std.mem.copyForwards(u8, &account_name_buffer_for_hashmap_value, &account_name_buffer);

                session.?.values.put("account_name", account_name_buffer_for_hashmap_value) catch {
                    r.setStatus(.internal_server_error);
                    errorPage(r, "Internal Server Error\n");
                    std.debug.print("alhamdo li Allah error while putting the account_name to the session\n", .{});
                    return;
                };
                std.debug.print("alhamdo li Allah will set session.account_name = {s}\n", .{account_name_buffer_for_hashmap_value});
                std.debug.print("alhamdo li Allah got account_name {s}\n", .{session.?.values.get("account_name") orelse [_]u8{0} ** 512});
            }

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

    var account_name_buffer: [64]u8 = [_]u8{0} ** 64;
    var account_password_buffer: [64]u8 = [_]u8{0} ** 64;

    std.mem.copyForwards(u8, &account_name_buffer, account_name_parsed);
    std.mem.copyForwards(u8, &account_password_buffer, account_password_parsed);

    if (null == accounts.get(account_name_buffer)) {
        accounts.put(account_name_buffer, account_password_buffer) catch {
            r.setStatus(.internal_server_error);
            errorPage(r, "Could not add user due to an internal error");
        };
        simplePage(r, "<p>alhamdo li Allah should be registred now</p>");
    } else {
        errorPage(r, "user already exists");
    }

    std.debug.print("alhamdo li Allah should now register '{s}':'{s}'\n", .{ account_name_parsed, account_password_parsed });
    simplePage(r, "<p>alhamdo li Allah</p>");
}

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    allocator = gpa.allocator();

    sessions = std.AutoHashMap(uuid.urn.Urn, *Session).init(allocator);
    defer sessions.deinit();

    accounts = std.AutoHashMap([64]u8, [64]u8).init(allocator);
    defer accounts.deinit();
    {
        var buffer_name: [64]u8 = [_]u8{0} ** 64;
        var buffer_password: [64]u8 = [_]u8{0} ** 64;

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
        std.debug.print("alahdmo li Allah name is: '{s}'\n", .{password.?});
    }

    var listener = zap.HttpListener.init(.{
        .port = 3000,
        .on_request = onRequest,
        // .public_folder = "public",
    });
    try listener.listen();

    zap.start(.{ .threads = 1, .workers = 1 });
}
