// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed rassoul Allah
const std = @import("std");
const pg = @import("pg");

var input_buffer_name: [33]u8 = undefined;
var stdou_buffer: [1024]u8 = undefined;

pub fn main() !void {
    const stdout = std.io.getStdOut();
    const stdin = std.io.getStdIn();

    _ = try stdout.write("بسم الله الرحمن الرحيم\n");

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();

    var pool = try pg.Pool.init(allocator, .{ .size = 5, .connect = .{
        .port = 5432,
        .host = "127.0.0.1",
    }, .auth = .{
        .username = "postgres",
        .database = "bismi_allah_db",
        .password = "bismi_allah",
        .timeout = 10_000,
    } });
    defer pool.deinit();

    var conn = try pool.acquire();
    defer conn.release();

    // create table if not exists
    _ = conn.exec("CREATE TABLE IF NOT EXISTS bismi_allah_table ( id SERIAL PRIMARY KEY, name VARCHAR(33) )", .{}) catch |err| {
        if (err != error.PG) return err;
        if (conn.err) |pge| std.log.err("alhamdo li Allah error: {s}\n", .{pge.message});
    };

    // insert values
    insert_values: while (true) {
        _ = try stdout.write("bismi Allah, please enter the desired name: ");
        const name_size = try stdin.read(&input_buffer_name);
        if (1 == name_size) break :insert_values;

        var stmt = conn.prepare("INSERT INTO bismi_allah_table (name) VALUES ($1)") catch |err| {
            if (err != error.PG) return err;
            if (conn.err) |pge| std.log.err("alhamdo li Allah error: {s}\n", .{pge.message});
            return err;
        };
        errdefer stmt.deinit();

        try stmt.bind(input_buffer_name[0 .. name_size - 1]);
        var result = try stmt.execute();
        try result.drain();

        input_buffer_name = [1]u8{0} ** input_buffer_name.len;
    }

    // get values thanks to Allah
    {
        var result = try conn.query("select id, name from bismi_allah_table where id > $1", .{0});
        defer result.deinit();

        while (try result.next()) |row| {
            const id = row.get(i32, 0);
            // this is only valid until the next call to next(), deinit() or drain()
            const name = row.get([]u8, 1);

            const msg = try std.fmt.bufPrint(&stdou_buffer, "alhamdo li Allah: {d} | {s}\n", .{ id, name });
            _ = try stdout.write(msg);
        }
    }
}
