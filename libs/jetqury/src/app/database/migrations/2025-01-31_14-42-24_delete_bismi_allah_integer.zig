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
    // try repo.createTable(
    //     "my_table",
    //     &.{
    //         t.primaryKey("id", .{}),
    //         t.column("my_string", .string, .{}),
    //         t.column("my_integer", .integer, .{}),
    //         t.timestamps(.{}),
    //     },
    //     .{},
    // );

    try repo.alterTable(
        "bismi_allah_table",
        .{
            .columns = .{
                .drop = &.{"bismi_allah_integer"},
            },
        },
    );
}

pub fn down(repo: anytype) !void {
    try repo.alterTable(
        "bismi_allah_table",
        .{
            .columns = .{
                .add = &.{
                    t.column("bismi_allah_integer", .integer, .{}),
                },
            },
        },
    );
}
