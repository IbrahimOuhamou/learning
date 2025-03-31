// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const jetzig = @import("jetzig");

pub fn index(request: *jetzig.Request) !jetzig.View {
    const query = jetzig.database.Query(.BismiAllahTable).select(.{ .id, .bismi_allah_string, .bismi_allah_text });

    const bismi_allah_data = try request.repo.all(query);

    var root = try request.data(.object);

    try root.put("bismi_allah_data", bismi_allah_data);

    return request.render(.ok);
}

pub fn get(id: []const u8, request: *jetzig.Request) !jetzig.View {
    // const query = jetzig.database.Query(.BismiAllahTable).find(id).select(.{.bismi_allah_string});
    const query = jetzig.database.Query(.BismiAllahTable).find(id);

    if (try request.repo.execute(query)) |bismi_allah| {
        var root = try request.data(.object);

        try root.put("bismi_allah", bismi_allah);
    } else return request.fail(.not_found);

    return request.render(.ok);
}

pub fn post(request: *jetzig.Request) !jetzig.View {
    const Params = struct {
        bismi_allah_string: []const u8,
        bismi_allah_text: []const u8,
    };
    const params = try request.expectParams(Params) orelse return request.fail(.unprocessable_entity);

    const query = jetzig.database.Query(.BismiAllahTable)
        .insert(.{
        .bismi_allah_string = params.bismi_allah_string,
        .bismi_allah_text = params.bismi_allah_text,
    });

    try request.repo.execute(query);

    return request.render(.created);
}

test "index" {
    var app = try jetzig.testing.app(std.testing.allocator, @import("routes"));
    defer app.deinit();

    const response = try app.request(.GET, "/bismi_allah_db", .{});
    try response.expectStatus(.ok);
}

test "get" {
    var app = try jetzig.testing.app(std.testing.allocator, @import("routes"));
    defer app.deinit();

    const response = try app.request(.GET, "/bismi_allah_db/example-id", .{});
    try response.expectStatus(.ok);
}

test "post" {
    var app = try jetzig.testing.app(std.testing.allocator, @import("routes"));
    defer app.deinit();

    const response = try app.request(.POST, "/bismi_allah_db", .{});
    try response.expectStatus(.created);
}
