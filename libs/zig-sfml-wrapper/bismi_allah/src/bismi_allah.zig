// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");

const c = @cImport({
    @cInclude("harfbuzz/hb.h");
});

const sf = struct {
    const sfml = @import("sfml");
    usingnamespace sfml;
    usingnamespace sfml.audio;
    usingnamespace sfml.graphics;
    usingnamespace sfml.window;
    usingnamespace sfml.system;
};

const font_data = @embedFile("res/KacstDigital.ttf");
const texture_data = @embedFile("res/warsh-1-scaled.jpg");

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم", .{});

    var window = try sf.graphics.RenderWindow.create(.{ .x = 1792, .y = 2560 }, 1, "bismi Allah", sf.window.Style.defaultStyle, null);
    defer window.destroy();
    window.setFramerateLimit(60);
    window.setSize(.{ .x = 800, .y = 600 });

    var font = try sf.graphics.Font.createFromMemory(font_data);
    defer font.destroy();

    const buffer = c.hb_buffer_create().?;
    c.hb_buffer_set_direction(buffer, c.HB_DIRECTION_RTL);
    c.hb_buffer_set_script(buffer, c.HB_SCRIPT_ARABIC);
    c.hb_buffer_set_language(buffer, c.hb_language_from_string("ar", 2));
    c.hb_buffer_add_utf8(buffer, "بسم الله الرحمن الرحيم", 22, 0, -1);
    defer c.hb_buffer_destroy(buffer);

    std.debug.print("alhamdo li Allah {s}\n", .{buffer});

    // var basmala_text = try sf.graphics.Text.createWithTextUnicode(sf.toUnicodeComptime("بسم الله الرحمن الرحيم"), font, 32);
    var basmala_text = try sf.graphics.Text.createWithTextUnicode(sf.toUnicodeComptime("\u{FEEA}\u{FEE0}\u{FEDF}\u{FE8D} \u{FEE2}\u{FEB4}\u{FE91}"), font, 32);
    defer basmala_text.destroy();
    basmala_text.setFillColor(sf.Color.Black);

    // var quran_texture = try sf.graphics.Texture.createFromMemory(texture_data, .{ .top = 0, .left = 0, .width = 0, .height = 0 });
    var quran_texture = try sf.graphics.Texture.createFromMemory(texture_data, .{ .top = 0, .left = 0, .width = 0, .height = 0 });
    defer quran_texture.destroy();
    quran_texture.setSmooth(true);

    var quran_sprite = try sf.graphics.Sprite.createFromTexture(quran_texture);
    defer quran_sprite.destroy();
    // quran_sprite.setScale(.{ .x = 0.5, .y = 0.2 });
    //quran_sprite.setTextureRect(.{ .top = 0, .left = 0, .width = 500, .height = 100 });

    var bg_color = sf.graphics.Color.Black;
    while (window.isOpen()) {
        while (window.pollEvent()) |event| {
            std.debug.print("alhamdo li Allah event {any}\n", .{event});
            switch (event) {
                .closed => window.close(),
                .key_pressed => {
                    if (event.key_pressed.code == .A) {
                        bg_color = sf.graphics.Color.Black;
                    }

                    if (event.key_pressed.code == .B) {
                        basmala_text.setScale(.{ .x = 1.2, .y = 1.2 });
                    }
                },
                .resized => {
                    // window.setSize(event.resized.size);
                    std.debug.print("alhamdo li Allah", .{});
                },
                else => {},
            }
        }

        window.clear(bg_color);

        window.draw(quran_sprite, null);
        window.draw(basmala_text, null);

        window.display();
    }
}
