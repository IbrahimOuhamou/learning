// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed rassoul Allah
const std = @import("std");
const pg = @import("pg");

var pool: *pg.Pool = undefined;

pub fn init(allocator :std.mem.Allocator) !void {
     pool = try pg.Pool.init(allocator, .{ .size = 5, .connect = .{
        .port = 5432,
        .host = "127.0.0.1",
    }, .auth = .{
        .username = "postgres",
        .database = "bismi_allah_db",
        .password = "bismi_allah",
        .timeout = 10_000,
    } });

    // if (null == pool) std.debug.print("alhamdo li Allah error cuse pool is null\n", .{});
}

pub fn deinit() void {
    pool.deinit();
}

pub fn acquire() !*pg.Conn {
    return try pool.acquire();
}
