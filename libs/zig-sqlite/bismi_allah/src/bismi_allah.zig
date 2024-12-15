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
    try db.exec("CREATE TABLE users1 (id TEXT PRIMARY KEY, age FLOAT)", .{});

    {
        const insert = try db.prepare(User, void, "INSERT INTO users1 VALUES (:id, :age)");
        defer insert.finalize();

        try insert.exec(.{ .id = sqlite.text("bismi Allah"), .age = 12 });
        try insert.exec(.{ .id = sqlite.text("alhamdo li Allah"), .age = null });
    }

    {
        const insert = try db.prepare(User, void, "INSERT INTO users1 VALUES (:id, :age)");
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
        const select = try db.prepare(struct { min_age: f32 }, User, "SELECT * FROM users1 WHERE age >= :min_age");
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
        const select = try db.prepare(struct {}, User, "SELECT * FROM users1");
        defer select.finalize();

        while (try select.step()) |row_user| {
            try stdout.print("alhamdo li Allah user: '{s}' | '{?d}'\n", .{ row_user.id.data, row_user.age });
        }
    }

    try bw.flush(); // don't forget to flush!

    {
        try db.exec(
            \\CREATE TABLE IF NOT EXISTS users (                                                                    
            \\  id INTEGER PRIMARY KEY,
            \\  login TEXT NOT NULL UNIQUE,
            \\  name TEXT NOT NULL UNIQUE,
            \\  email TEXT NOT NULL,
            \\  password_hash TEXT NOT NULL,
            \\  password_salt TEXT NOT NULL
            \\)
        , .{});

        try db.exec("INSERT INTO users (login, name, email, password_hash, password_salt) VALUES ('bismi_allah_user', 'bismi_allah_username', 'ouhamouy10@gmail.com', '5a26cff1f99a18b5ccdd414d4e967898fb5fee3ef47bae419d2fbbadf4a60890', '123456789012'), ('bismi_allah_user2', 'bismi_allah_username2', 'ouhamouy10@gmail.com', '5a26cff1f99a18b5ccdd414d4e967898fb5fee3ef47bae419d2fbbadf4a60890', '123456789012')", .{});

        const select_stmt = try db.prepare(
            struct { login: sqlite.Text },
            struct {
                id: i32,
                login: sqlite.Text,
                name: sqlite.Text,
                email: sqlite.Text,
                password_hash: sqlite.Text,
                password_salt: sqlite.Text,
            },
            "select * from users where login = :login",
        );
        defer select_stmt.finalize();

        try select_stmt.bind(.{ .login = sqlite.text("bismi_allah_user") });

        while (try select_stmt.step()) |row_user| {
            try stdout.print("alhamdo li Allah user id == '{d}'\n", .{row_user.id});
        }
    }

    {
        errdefer |err| std.debug.print("alhamdo li Allah error in function: 'exists()' '{any}'\n", .{err});
        const select_stmt = try db.prepare(struct { login: sqlite.Text }, struct { id: u32 }, "SELECT id FROM users WHERE login = :login");
        defer select_stmt.finalize();

        try select_stmt.bind(.{ .login = sqlite.text("bismi_allah_user") });
        try stdout.print("alhamdo li Alllah: '{any}'\n", .{null != try select_stmt.step()});
    }

    try bw.flush(); // don't forget to flush!
}
