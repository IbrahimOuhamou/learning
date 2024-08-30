// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah

const std = @import("std");
const c = @cImport({
    @cInclude("SDL2/SDL.h");
});

var rect: c.SDL_Rect = .{ .x = 30, .y = 30, .w = 30, .h = 30 };
var viewport: c.SDL_Rect = .{ .x = -30, .y = 0, .w = 400, .h = 140 };

pub fn main() !void {
    if (c.SDL_Init(c.SDL_INIT_VIDEO) != 0) {
        c.SDL_Log("Unable to initialize SDL: %s", c.SDL_GetError());
        return error.SDLInitializationFailed;
    }
    defer c.SDL_Quit();

    const screen = c.SDL_CreateWindow("bismi Allah", c.SDL_WINDOWPOS_UNDEFINED, c.SDL_WINDOWPOS_UNDEFINED, 400, 140, c.SDL_WINDOW_OPENGL) orelse
        {
        c.SDL_Log("Unable to create window: %s", c.SDL_GetError());
        return error.SDLInitializationFailed;
    };
    defer c.SDL_DestroyWindow(screen);

    const renderer = c.SDL_CreateRenderer(screen, -1, 0) orelse {
        c.SDL_Log("Unable to create renderer: %s", c.SDL_GetError());
        return error.SDLInitializationFailed;
    };
    defer c.SDL_DestroyRenderer(renderer);

    var quit = false;
    while (!quit) {
        var event: c.SDL_Event = undefined;
        while (c.SDL_PollEvent(&event) != 0) {
            switch (event.type) {
                c.SDL_QUIT => {
                    quit = true;
                },
                c.SDL_KEYDOWN => {
                    // std.debug.print("alhamdo li Allah event.key: '{any}'\n", .{event.key});
                    if (event.key.keysym.scancode == c.SDL_SCANCODE_LEFT) viewport.x += 10;

                    const keys = c.SDL_GetKeyboardState(null);
                    if (0 != keys[c.SDL_SCANCODE_RIGHT]) viewport.x -= 10;
                },
                else => {},
            }
        }

        _ = c.SDL_SetRenderDrawColor(renderer, 100, 100, 100, 255);
        _ = c.SDL_RenderClear(renderer);
        defer c.SDL_RenderPresent(renderer);

        _ = c.SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
        _ = c.SDL_RenderFillRect(renderer, &rect);

        _ = c.SDL_RenderSetViewport(renderer, &viewport);
    }
}
