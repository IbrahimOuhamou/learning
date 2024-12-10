// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const sqlite = @import("sqlite");

pub fn main() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();
    const stdin = std.io.getStdIn();

    try stdout.print("بسم الله الرحمن الرحيم\n", .{});

    const db = try sqlite.Database.open(.{});
    defer db.close();

    const User = struct {
        id: sqlite.Text,
        age: ?f32,
    };
    try db.exec("CREATE TABLE users (id TEXT PRIMARY KEY, age FLOAT)", .{});

    {
        const insert = try db.prepare(User, void, "INSERT INTO users VALUES (:id, :age)");
        defer insert.finalize();

        try insert.exec(.{ .id = sqlite.text("bismi Allah"), .age = 12 });
        try insert.exec(.{ .id = sqlite.text("alhamdo li Allah"), .age = null });
    }

    {
        const insert = try db.prepare(User, void, "INSERT INTO users VALUES (:id, :age)");
        defer insert.finalize();

        var input_buffer_id: [1024]u8 = undefined;
        var input_buffer_age: [10]u8 = undefined;

        insert_inputs: while (true) {
            _ = try stdout.write("bismi Allah, enter the desired id: ");
            try bw.flush(); // don't forget to flush!
            const id_size = try stdin.read(&input_buffer_id);
            if (1 == id_size) break :insert_inputs;

            _ = try stdout.write("bismi Allah, enter the desired age: ");
            try bw.flush(); // don't forget to flush!
            const age_size = try stdin.read(&input_buffer_age);
            const age: ?f32 = if (1 == age_size) null else try std.fmt.parseFloat(f32, input_buffer_age[0 .. age_size - 1]);

            try insert.exec(.{ .id = sqlite.text(input_buffer_id[0 .. id_size - 1]), .age = age });
        }
    }

    {
        const select = try db.prepare(struct { min_age: f32 }, User, "SELECT * FROM users WHERE age >= :min_age");
        defer select.finalize();

        {
            try select.bind(.{ .min_age = 0 });
            defer select.reset();

            while (try select.step()) |row_user| {
                try stdout.print("alhamdo li Allah: '{s}' | '{?d}'\n", .{ row_user.id.data, row_user.age });
            }
        }
    }

    _ = try stdout.write("\n\n");

    {
        const select = try db.prepare(struct {}, User, "SELECT * FROM users");
        defer select.finalize();

        while (try select.step()) |row_user| {
            try stdout.print("alhamdo li Allah user: '{s}' | '{?d}'\n", .{ row_user.id.data, row_user.age });
        }
    }

    try bw.flush(); // don't forget to flush!
}
