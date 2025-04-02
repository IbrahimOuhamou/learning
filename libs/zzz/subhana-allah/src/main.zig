// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const log = std.log.scoped(.@"subhana-allah");

const zzz = @import("zzz");
const http = zzz.HTTP;

const tardy = zzz.tardy;
const Tardy = tardy.Tardy(.auto);
const Runtime = tardy.Runtime;
const Socket = tardy.Socket;

const Server = http.Server;
const Router = http.Router;
const Context = http.Context;
const Route = http.Route;
const Respond = http.Respond;

fn base_handler(ctx: *const Context, _: void) !Respond {
    return ctx.response.apply(.{
        .status = .OK,
        .mime = http.Mime.JSON,
        .body =
        \\{"name":"alhamdo li Allah"}
        ,
    });
}

fn dynamic_route_handler(ctx: *const Context, _: void) !Respond {
    const response_slice = try std.fmt.allocPrint(ctx.allocator,
        \\{{
        \\  "dynamic": {{
        \\    "signed": "{d}",
        \\    "string": "{s}",
        \\    "remaining": "{s}"
        \\  }}
        \\}}
    , .{ ctx.captures[0].signed, ctx.captures[1].string, ctx.captures[2].remaining });

    std.debug.print("alhamdo li Allah response: '{s}'\n", .{response_slice});

    return ctx.response.apply(.{
        .status = .OK,
        .mime = http.Mime.JSON,
        .body = response_slice,
    });
}

fn cookie_route_handler(ctx: *const Context, _: void) !Respond {
    const query_cookies_name = ctx.queries.get("name");
    const query_cookies_value = ctx.queries.get("value");

    var response_body = try std.mem.concat(ctx.allocator, u8, &.{"<h1>la ilaha illa Allah Mohammed Rassoul Allah</h1><h3>Request Cookies:</h3>"});

    const cookies = ctx.request.cookies;
    var cookies_iter = cookies.iterator();
    while (cookies_iter.next()) |cookie| {
        log.debug("cookie: k={s} v={s}", .{ cookie.key_ptr.*, cookie.value_ptr.* });
        const new_response_body = try std.mem.concat(ctx.allocator, u8, &.{
            response_body,
            cookie.key_ptr.*,
            "=",
            cookie.value_ptr.*,
            "<br/>",
        });
        ctx.allocator.free(response_body);

        response_body = new_response_body;
    }

    const cookie = http.Cookie.init(query_cookies_name orelse query_cookies_value orelse "", query_cookies_value orelse "");

    const new_response_body = try std.mem.concat(ctx.allocator, u8, &.{
        response_body,
        "<h3>New Cookie:</h3>",
        query_cookies_name orelse query_cookies_value orelse "",
        "=",
        query_cookies_value orelse "",
        "<br>",
    });
    ctx.allocator.free(response_body);
    response_body = new_response_body;

    const cookie_12 = cookies.map.get("bismi-allah");
    std.debug.print("alhamdo li Allah: cookies.map.get.(\"bismi-allah\"): '{?s}'\n", .{cookie_12});

    return ctx.response.apply(.{
        .status = .OK,
        .mime = http.Mime.HTML,
        .body = response_body,
        .headers = &.{
            .{ "Set-Cookie", try cookie.to_string_alloc(ctx.allocator) },
        },
    });
}

const FormParams = struct {
    id: i32 = 0,
    name: []const u8,
    age: u8,
    options: ?[]const u8 = null,
};
fn form_post_handler(ctx: *const Context, _: void) !Respond {
    // const params = try http.Form(FormParams).parse(ctx.allocator, ctx);

    const params = try std.json.parseFromSlice(FormParams, ctx.allocator, ctx.request.body orelse return error.BodyEmpty, .{.ignore_unknown_fields = true});
    defer params.deinit();

    var json_array_list = std.ArrayList(u8).init(ctx.allocator);
    try std.json.stringify(params.value, .{}, json_array_list.writer());

    return ctx.response.apply(.{
        .status = .OK,
        .body = json_array_list.items,
        .mime = http.Mime.JSON,
    });
}

pub fn main() !void {
    const host: []const u8 = "0.0.0.0";
    const port: u16 = 9862;

    var gpa = std.heap.GeneralPurposeAllocator(.{ .thread_safe = true }){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    var t = try Tardy.init(allocator, .{ .threading = .auto });
    defer t.deinit();

    var router = try Router.init(allocator, &.{
        Route.init("/").get({}, base_handler).layer(),
        Route.init("/dynamic/%i/%s/%r").get({}, dynamic_route_handler).layer(),
        Route.init("/cookies").get({}, cookie_route_handler).layer(),
        Route.init("/form").post({}, form_post_handler).layer(),
        Route.init("/form").embed_file(
            .{ .mime = http.Mime.HTML },
            @embedFile("static/form.html"),
        ).layer(),
    }, .{});
    defer router.deinit(allocator);

    var socket = try Socket.init(.{ .tcp = .{ .host = host, .port = port } });
    defer socket.close_blocking();
    try socket.bind();
    try socket.listen(4096);

    const EntryParams = struct {
        router: *const Router,
        socket: Socket,
    };

    std.debug.print("alhamdo li Allah listening on '{s}':'{d}'\n", .{ host, port });

    try t.entry(
        EntryParams{ .router = &router, .socket = socket },
        struct {
            fn entry(rt: *Runtime, p: EntryParams) !void {
                var server = Server.init(.{
                    .stack_size = 1024 * 1024 * 4,
                    .socket_buffer_bytes = 1024 * 2,
                    .keepalive_count_max = null,
                    .connection_count_max = 1024,
                });
                try server.serve(rt, p.router, .{ .normal = p.socket });
            }
        }.entry,
    );
}
