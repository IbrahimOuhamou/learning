// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const log = std.log.scoped(.@"subhana-allah");

const zzz = @import("zzz");
const jwt = @import("jwt");
const http = zzz.HTTP;

const tardy = zzz.tardy;
const Tardy = tardy.Tardy(.auto);
const Runtime = tardy.Runtime;
const Socket = tardy.Socket;
const Dir = tardy.Dir;

const Server = http.Server;
const Router = http.Router;
const Context = http.Context;
const Route = http.Route;
const Respond = http.Respond;
const Next = http.Next;
const Middleware = http.Middleware;
const Mime = http.Mime;

pub const MD = Mime.generate("text/markdown; charset=utf-8", "md", "Markdown Document");

const Jwt = struct {
    user_id: i32,
};

// todo: use env var
const secret = "LaIlahaIllaAllah";

const SecureFile = struct {
    id: i32,
    name: []const u8,
    mime: Mime,
};
const secure_files = [_]SecureFile{
    .{ .id = 1, .name = "BismiAllah.md", .mime = MD },
};

fn download_handler(ctx: *const Context, dir: Dir) !Respond {
    //TODO: use db incha2Allah

    const response = ctx.response;

    // Resolving the requested file.
    const file_id = ctx.captures[0].unsigned;
    const secure_file: SecureFile = find_file: {
        for (secure_files, 0..) |file, i| if(file.id == file_id) break :find_file secure_files[i];
        
        return ctx.response.apply(.{
            .status = .@"Not Found",
            .mime = Mime.HTML,
        });
    };

    // const search_path = secure_file.name;
    // Todo: change to secure_file's name
    const file_path_z = try ctx.allocator.dupeZ(u8, secure_file.name);

    const file = dir.open_file(ctx.runtime, file_path_z, .{ .mode = .read }) catch |e| switch (e) {
        error.NotFound => {
            return ctx.response.apply(.{
                .status = .@"Not Found",
                .mime = Mime.HTML,
            });
        },
        else => return e,
    };
    const stat = try file.stat(ctx.runtime);

    var hash = std.hash.Wyhash.init(0);
    hash.update(std.mem.asBytes(&stat.size));
    if (stat.modified) |modified| {
        hash.update(std.mem.asBytes(&modified.seconds));
        hash.update(std.mem.asBytes(&modified.nanos));
    }
    const etag_hash = hash.final();

    const calc_etag = try std.fmt.allocPrint(ctx.allocator, "\"{d}\"", .{etag_hash});
    try response.headers.put("ETag", calc_etag);

    // If we have an ETag on the request...
    if (ctx.request.headers.get("If-None-Match")) |etag| {
        if (std.mem.eql(u8, etag, calc_etag)) {
            // If the ETag matches.
            return ctx.response.apply(.{
                .status = .@"Not Modified",
                .mime = Mime.HTML,
            });
        }
    }

    // apply the fields.
    response.status = .OK;
    response.mime = secure_file.mime;

    try response.headers_into_writer(ctx.header_buffer.writer(), stat.size);
    const headers = ctx.header_buffer.items;
    const length = try ctx.socket.send_all(ctx.runtime, headers);
    if (headers.len != length) return error.SendingHeadersFailed;

    var buffer = ctx.header_buffer.allocatedSlice();
    while (true) {
        const read_count = file.read(ctx.runtime, buffer, null) catch |e| switch (e) {
            error.EndOfFile => break,
            else => return e,
        };

        _ = ctx.socket.send(ctx.runtime, buffer[0..read_count]) catch |e| switch (e) {
            error.Closed => break,
            else => return e,
        };
    }

    return .responded; 
}

fn login_handler(ctx: *const Context, _: void) !Respond {
    const params = try std.json.parseFromSlice(Jwt, ctx.allocator, ctx.request.body orelse return error.BodyEmpty, .{.ignore_unknown_fields = true});
    defer params.deinit();
    const token = try jwt.encode(ctx.allocator,
        .{ .alg = .HS256 },
        .{
            .sub = "Auth",
            .exp = std.time.timestamp() + 100000,
            .user_id = params.value.user_id,
        },
        .{ .secret = secret },
    );

    return ctx.response.apply(.{
        .status = .OK,
        .mime = http.Mime.JSON,
        .body = \\{"status": 200, "message": "ok"}
        ,
        .headers = &.{
            .{"Authorization", token},
        },
    });
}

fn jwt_middleware(next: *Next, _: void) !Respond {
    const header_token = next.context.request.headers.get("Authorization") orelse return next.context.response.apply(.{
        .status = .Unauthorized,
        .mime = http.Mime.JSON,
        .body = 
        \\{"error": 401, "message": "Unauthorized, no jwt provided"}
        ,
    });

    const ctx = next.context;

    const decoded_token = try jwt.decode(
        ctx.allocator,
        Jwt,
        header_token,
        .{ .secret = secret },
        .{},
    );

    try next.context.storage.put(Jwt, decoded_token.claims);

    return next.run();
}

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

    const secure_dir = Dir.from_std(try std.fs.openDirAbsolute("/tmp/zzz/files", .{.access_sub_paths = false, .no_follow = true}));

    var router = try Router.init(allocator, &.{
        Route.init("/").get({}, base_handler).layer(),
        Route.init("/dynamic/%i/%s/%r").get({}, dynamic_route_handler).layer(),
        Route.init("/cookies").get({}, cookie_route_handler).layer(),
        Route.init("/form").embed_file(
            .{ .mime = http.Mime.HTML },
            @embedFile("static/form.html"),
        ).layer(),

        Route.init("/login").post({}, login_handler).layer(),

        // only if logged in
        Middleware.init({}, jwt_middleware).layer(),
        Route.init("/form").post({}, form_post_handler).layer(),
        Route.init("/download/%u").get(secure_dir, download_handler).layer(),
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
