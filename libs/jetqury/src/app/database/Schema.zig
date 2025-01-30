// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
const jetquery = @import("jetzig").jetquery;

pub const BismiAllahTable = jetquery.Model(@This(), "bismi_allah_table", struct {
    id: i32,
    bismi_allah_integer: i32,
    bismi_allah_string: []const u8,
    bismi_allah_text: []const u8,
    created_at: jetquery.DateTime,
    updated_at: jetquery.DateTime,
}, .{});
