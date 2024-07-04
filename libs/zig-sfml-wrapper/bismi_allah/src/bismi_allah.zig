// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const sfml = @import("sfml");

const font_data = @embedFile("res/KacstDigital.ttf");

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم", .{});

    var window = try sfml.graphics.RenderWindow.create(.{ .x = 800, .y = 600 }, 32, "bismi Allah", sfml.window.Style.defaultStyle, null);
    defer window.destroy();
    window.setFramerateLimit(60);

    var font = try sfml.graphics.Font.createFromMemory(font_data);
    // var font = try sfml.graphics.Font.createFromFile("res/Clickuper.ttf");
    defer font.destroy();

    // var basmala_text = try sfml.graphics.Text.createWithText("\u{FEEA}\u{FEE0}\u{FEDF}\u{FE8D} \u{FEE2}\u{FEB4}\u{FE91}", font, 32);
    var basmala_text = try sfml.graphics.Text.createWithText("بسم الله الرحمن الرحيم", font, 32);
    // var basmala_text = try sfml.graphics.Text.createWithText("la ilaha illa Allah Mohammed Rassoul Allah", font, 32);
    // var basmala_text = try sfml.graphics.Text.createWithText(&basmala_unicode, font, 32);
    defer basmala_text.destroy();

    var bg_color = sfml.graphics.Color.Blue;
    while (window.isOpen()) {
        while (window.pollEvent()) |event| {
            std.debug.print("alhamdo li Allah event {any}\n", .{event});
            switch (event) {
                .closed => window.close(),
                .key_pressed => {
                    if (event.key_pressed.code == .A) {
                        bg_color = sfml.graphics.Color.Black;
                    }

                    if (event.key_pressed.code == .B) {
                        basmala_text.setScale(.{ .x = 1.2, .y = 1.2 });
                    }
                },
                else => {},
            }
        }

        window.clear(bg_color);

        window.draw(basmala_text, null);

        window.display();
    }
}
