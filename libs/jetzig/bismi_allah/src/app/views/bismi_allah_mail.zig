// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed rassoul Allah
const std = @import("std");
const jetzig = @import("jetzig");

pub fn index(request: *jetzig.Request, data: *jetzig.Data) !jetzig.View {
    var root = try data.root(.object);
    try root.put("bismi_allah_message", data.string("La ilaha illa Allah"));

    const mail = request.mail("bismi_allah", .{ .to = &.{"bismi_allah@bismi_allah.com"} });

    try mail.deliver(.background, .{});

    return request.render(.ok);
}
