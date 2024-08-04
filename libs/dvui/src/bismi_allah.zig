//بسم الله الرحمن الرحيم
//la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const dvui = @import("dvui");

const SDLBackend = @import("SDLBackend");
const c = @cImport({
    @cInclude("SDL2/SDL.h");
});

var window: *c.SDL_Window = undefined;
var renderer: *c.SDL_Renderer = undefined;

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    if (c.SDL_Init(c.SDL_INIT_VIDEO) < 0) {
        std.debug.print("alhamdo li Allah Couldn't initialize SDL: {s}\n", .{c.SDL_GetError()});
        return error.BackendError;
    }

    window = c.SDL_CreateWindow("alhamdo li Allah DVUI Ontop Example", c.SDL_WINDOWPOS_UNDEFINED, c.SDL_WINDOWPOS_UNDEFINED, @as(c_int, @intCast(640)), @as(c_int, @intCast(480)), c.SDL_WINDOW_ALLOW_HIGHDPI | c.SDL_WINDOW_RESIZABLE) orelse {
        std.debug.print("Failed to open window: {s}\n", .{c.SDL_GetError()});
        return error.BackendError;
    };
    _ = c.SDL_SetHint(c.SDL_HINT_RENDER_SCALE_QUALITY, "linear");
    defer c.SDL_DestroyWindow(window);

    renderer = c.SDL_CreateRenderer(window, -1, c.SDL_RENDERER_PRESENTVSYNC) orelse {
        std.debug.print("alhamdo li Allah Failed to create renderer: {s}\n", .{c.SDL_GetError()});
        return error.BackendError;
    };
    _ = c.SDL_SetRenderDrawBlendMode(renderer, c.SDL_BLENDMODE_BLEND);
    defer c.SDL_DestroyRenderer(renderer);

    main_loop: while (true) {
        var event: c.SDL_Event = undefined;
        while (c.SDL_PollEvent(&event) != 0) {
            switch (event) {
                c.SDL_QUIT => {
                    break :main_loop;
                },
                c.SDL_KEYDOWN => {},
                else => {},
            }
        }
    }
}
