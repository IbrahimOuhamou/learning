// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const jetquery = @import("jetquery");
const t = jetquery.schema.table;

pub fn up(repo: anytype) !void {
    // The `up` function runs when a migration is applied.
    //
    // This example migration creates a table named `my_table` with the following columns:
    // * `id`
    // * `my_string`
    // * `my_integer`
    // * `created_at`
    // * `updated_at`
    //
    // When present, `created_at` and `updated_at` are automatically populated by JetQuery
    // when a record is created/modified.
    //
    // See https://www.jetzig.dev/documentation/sections/database/migrations for more details.
    //
    // Run `jetzig database migrate` to apply migrations.
    //
    // Then run `jetzig database reflect` to auto-generate `src/app/database/Schema.zig`
    // (or manually edit the Schema to include your new table).
    //
    try repo.createTable(
        "bismi_allah_table",
        &.{
            t.primaryKey("id", .{}),
            t.column("bismi_allah_integer", .integer, .{}),
            t.column("bismi_allah_string", .string, .{}),
            t.column("bismi_allah_text", .text, .{}),
            t.timestamps(.{}),
        },
        .{},
    );
}

pub fn down(repo: anytype) !void {
    // The `down` function runs when a migration is rolled back.
    // In this case, we drop our example table `my_table`.
    //
    // Run `jetzig database rollback` to roll back a migration.
    //
    try repo.dropTable("my_table", .{});
}
