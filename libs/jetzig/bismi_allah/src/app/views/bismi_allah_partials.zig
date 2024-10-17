// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed rassoul Allah
const std = @import("std");
const jetzig = @import("jetzig");

pub const layout = "bismi_allah";

pub fn index(request: *jetzig.Request, data: *jetzig.Data) !jetzig.View {
    var root = try data.root(.object);

    var bismi_allah_object = try data.object();
    try bismi_allah_object.put("basmala", data.string("bismi Allah"));
    try bismi_allah_object.put("hamd", data.string("al hamdo li Allah"));

    try root.put("bismi_allah_object", bismi_allah_object);

    return request.render(.ok);
}

test "index" {
    var app = try jetzig.testing.app(std.testing.allocator, @import("routes"));
    defer app.deinit();

    const response = try app.request(.GET, "/bismi_allah_partials", .{});
    try response.expectStatus(.ok);
}
