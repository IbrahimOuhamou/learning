const std = @import("std");
const jetzig = @import("jetzig");

pub const layout = "bismi_allah";

pub fn index(request: *jetzig.Request, data: *jetzig.Data) !jetzig.View {
    var root = try data.root(.object);

    try root.put("logged_in", data.boolean(true));

    const session = try request.session();

    if (try session.get("user")) |user| {
        try root.put("user", user);
    }

    return request.render(.ok);
}

test "index" {
    var app = try jetzig.testing.app(std.testing.allocator, @import("routes"));
    defer app.deinit();

    const response = try app.request(.GET, "/account", .{});
    try response.expectStatus(.ok);
}
