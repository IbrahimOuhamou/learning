// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah

const std = @import("std");
const sqlt = @import("sqlt");

const Sqlite = sqlt.Sqlite;

const User = struct {
    const Permission = enum(u32) { none = 0, admin = 1 };
    const Country = enum { malysia, syria };

    name: []const u8,
    perms: Permission,
    country: Country,
    age: ?i32,
    weight: f32 = 10.0,
};

const Product = struct {
    id: i32,
    name: []const u8,
    price: f32,
    stock: i32,
};

pub fn main() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("بسم الله الرحمن الرحيم\n", .{});
    try bw.flush(); // Don't forget to flush!

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    const conn = try Sqlite.open(":memory:");
    defer conn.close();

    try sqlt.migrate(allocator, conn);

    try conn.execute(
        \\insert into users (name, age, perms, country) values (?, ?, ?, ?)
    , .{ "Alice", 25, User.Permission.admin, User.Country.syria });

    try conn.execute(
        \\insert into users (name, age, perms, country) values (?, ?, ?, ?)
    , .{ "Jane", 99, User.Permission.none, User.Country.malysia });

    try conn.execute(
        \\insert into users (name, age, perms, country) values (?, ?, ?, ?)
    , .{ "Girl", 7, User.Permission.none, User.Country.syria });

    try conn.execute(
        \\insert into users (name, age, perms, country) values (?, ?, ?, ?)
    , .{ "Adam", null, User.Permission.none, User.Country.malysia });

    const john = try conn.fetch_optional(allocator, User,
        \\ select name, age, perms, country from users
        \\ where name = ?
    , .{"John"});

    const all_users = try conn.fetch_all(allocator, User, "select * from users", .{});

    try conn.execute(
    \\ insert into products (name, price, stock) values (?, ?, ?)
    , .{ "misbaha", 12.0, 13 });

    try conn.execute(
    \\ insert into products (name, price, stock) values (?, ?, ?)
    , .{ "zarbia", 12.0, 13 });

    const all_products = try conn.fetch_all(allocator, Product, "select * from products", .{});

    defer allocator.free(all_products);
    defer for (all_products) |product| allocator.free(product.name);
    defer allocator.free(all_users);
    defer for (all_users) |user| allocator.free(user.name);

    std.debug.print("john is {?}\n", .{john});

    for (all_users) |user| try stdout.print(
        "{s}'s age: {?d} + weight: {?d} | perms: {s} + country: {s}\n",
        .{ user.name, user.age, user.weight, @tagName(user.perms), @tagName(user.country) },
    );
    try bw.flush();
    for (all_products) |product| try stdout.print(
        "{d}: {s}'s price: {d}. stock {d}\n",
        .{ product.id, product.name, product.price,product.stock},
    );
    try bw.flush();
}
