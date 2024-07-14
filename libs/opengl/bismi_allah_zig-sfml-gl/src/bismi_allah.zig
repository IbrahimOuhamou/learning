// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const gl = @import("zgl");
const sf = struct {
    const sfml = @import("sfml");
    usingnamespace sfml;
    usingnamespace sfml.audio;
    usingnamespace sfml.graphics;
    usingnamespace sfml.window;
    usingnamespace sfml.system;
};

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    var window = try sf.graphics.RenderWindow.create(.{ .x = 1000, .y = 600 }, 1, "bismi Allah", sf.window.Style.defaultStyle, null);
    defer window.destroy();
    window.setFramerateLimit(60);
    window.setSize(.{ .x = 800, .y = 600 });
    _ = sf.c.sfRenderWindow_setActive(window._ptr, 1);

    sf.c.sfRenderWindow_pushGLStates(window._ptr);

    // Use classic OpenGL flavour
    const vao = gl.createVertexArray();
    defer gl.deleteVertexArray(vao);

    var bg_color = sf.graphics.Color.Black;
    while (window.isOpen()) {
        while (window.pollEvent()) |event| {
            switch (event) {
                .closed => window.close(),
                .key_pressed => {
                    if (event.key_pressed.code == .A) {
                        bg_color = sf.graphics.Color.Black;
                    }
                },
                .resized => {},
                else => {},
            }
        }

        window.clear(bg_color);

        window.display();
    }
}
