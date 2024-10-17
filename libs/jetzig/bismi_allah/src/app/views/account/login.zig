// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed rassoul Allah
const std = @import("std");
const jetzig = @import("jetzig");

pub const layout = "bismi_allah";

pub fn index(request: *jetzig.Request, data: *jetzig.Data) !jetzig.View {
    _ = data;
    return request.render(.ok);
}

pub fn post(request: *jetzig.Request, data: *jetzig.Data) !jetzig.View {
    _ = data;

    const params = try request.params();

    const user_login_input = if (params.get("user_login")) |user_login_input| user_login: {
        switch (user_login_input.*) {
            .string => |string| break :user_login string,
            else => return request.redirect("/account/login", .moved_permanently),
        }
    } else return request.redirect("/account/login", .moved_permanently);
    const user_passwrod_input = if (params.get("user_passwrod")) |user_passwrod_input| user_passwrod: {
        switch (user_passwrod_input.*) {
            .string => |string| break :user_passwrod string,
            else => return request.redirect("/account/login", .moved_permanently),
        }
    } else return request.redirect("/account/login", .moved_permanently);

    if (try request.store.get("users")) |users| {
        const users_interator = users.array.iterator();
        while (users_interator.next()) |user| {
            const user_login = user.getT(.string, "login") orelse continue;
            const user_passwrod = user.getT(.string, "password") orelse "";

            if (std.mem.eql(u8, user_login, user_login_input.value) and std.mem.eql(u8, user_passwrod, user_passwrod_input.value)) {
                const session = try request.session();
                try session.put("user", user);
                return request.render(.created);
            }
        }
    }

    return request.redirect("/account/login", .moved_permanently);
}

test "index" {
    var app = try jetzig.testing.app(std.testing.allocator, @import("routes"));
    defer app.deinit();

    const response = try app.request(.GET, "/account/login", .{});
    try response.expectStatus(.ok);
}

test "post" {
    var app = try jetzig.testing.app(std.testing.allocator, @import("routes"));
    defer app.deinit();

    const response = try app.request(.POST, "/account/login", .{});
    try response.expectStatus(.created);
}
