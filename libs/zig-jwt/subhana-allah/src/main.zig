// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah

const std = @import("std");
const jwt = @import("jwt");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    // 👇 encode as a token jwt from its components
    const token = try jwt.encode(
        allocator,
        // 👇 header, at a minimum declaring an algorithm
        .{ .alg = .HS256 },
        // 👇 claims
        .{
            .sub = "بسم الله الرحمن الرحيم",
            .exp = std.time.timestamp() - 10,
            // .aud = "none",
            .alhamdo_li_allah = "alhamdo li Allah al aliyi al athimi",
        },
        // 👇 encoding key used to sign token
        .{ .secret = "secret" },
    );
    defer allocator.free(token);

    std.debug.print("alhamdo li Allah raw token: '{s}'\n", .{token});

    // 👇 decode token in to its respective parts
    var decoded = try jwt.decode(
        allocator,
        // 👇 the claims set we expect
        struct { sub: []const u8, alhamdo_li_allah: []const u8 },
        // 👇 the raw encoded token
        token,
        // 👇 decoding key used to verify encoded token's signature
        .{ .secret = "secret" },
        // 👇 verification rules that must hold for the token to be successfully decoded.
        // this includes sensible defaults.
        .{},
    );
    defer decoded.deinit();

    std.debug.print("alhamdo li Allah decoded token claims: '{s}'\n", .{decoded.claims.alhamdo_li_allah});
}
