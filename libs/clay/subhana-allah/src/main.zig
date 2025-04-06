// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
const std = @import("std");
const clay = @import("zclay");
const c = @import("c.zig").c;
const clay_sdl_renderer = @import("renderers/SDL3/clay_renderer_SDL3.zig");

const light_grey: clay.Color = .{ 224, 215, 210, 255 };
const red: clay.Color = .{ 168, 66, 28, 255 };
const orange: clay.Color = .{ 225, 138, 50, 255 };
const white: clay.Color = .{ 250, 250, 255, 255 };

const sidebar_item_layout: clay.LayoutConfig = .{ .sizing = .{ .w = .grow, .h = .fixed(50) } };

const font_size = 24;

// Re-useable components are just normal functions
fn sidebarItemComponent(index: u32) void {
    clay.UI()(.{
        .id = .IDI("SidebarBlob", index),
        .layout = sidebar_item_layout,
        .background_color = orange,
    })({});
}

// An example function to begin the "root" of your layout tree
fn createLayout(profile_picture: *c.SDL_Surface) clay.ClayArray(clay.RenderCommand) {
    clay.beginLayout();
    clay.UI()(.{
        .id = .ID("OuterContainer"),
        .layout = .{ .direction = .left_to_right, .sizing = .grow, .padding = .all(16), .child_gap = 16 },
        .background_color = white,
    })({
        clay.UI()(.{
            .id = .ID("SideBar"),
            .layout = .{
                .direction = .top_to_bottom,
                .sizing = .{ .h = .grow, .w = .fixed(300) },
                .padding = .all(16),
                .child_alignment = .{ .x = .center, .y = .top },
                .child_gap = 16,
            },
            .background_color = light_grey,
        })({
            clay.UI()(.{
                .id = .ID("ProfilePictureOuter"),
                .layout = .{ .sizing = .{ .w = .grow }, .padding = .all(16), .child_alignment = .{ .x = .left, .y = .center }, .child_gap = 16 },
                .background_color = red,
            })({
                clay.UI()(.{
                    .id = .ID("ProfilePicture"),
                    .layout = .{ .sizing = .{ .h = .fixed(60), .w = .fixed(60) } },
                    .image = .{ .source_dimensions = .{ .h = 60, .w = 60 }, .image_data = @ptrCast(profile_picture) },
                })({});
                clay.text("Clay - UI Library", .{ .font_size = font_size, .color = light_grey });
            });

            for (0..5) |i| sidebarItemComponent(@intCast(i));
        });

        clay.UI()(.{
            .id = .ID("MainContent"),
            .layout = .{ .sizing = .grow },
            .background_color = light_grey,
        })({
            //...
        });
    });
    return clay.endLayout();
}

pub fn main() !void {
    // Allocator for Clay
    const allocator = std.heap.c_allocator;

    const window_w = 640;
    const window_h = 480;

    // Initialize Clay
    const min_memory_size: u32 = clay.minMemorySize();
    const memory = try allocator.alloc(u8, min_memory_size);
    defer allocator.free(memory);
    const arena: clay.Arena = clay.createArenaWithCapacityAndMemory(memory);
    _ = clay.initialize(arena, .{ .w = window_w, .h = window_h }, .{});

    try errify(c.SDL_Init(c.SDL_INIT_VIDEO));
    defer c.SDL_Quit();

    try errify(c.TTF_Init());
    defer c.TTF_Quit();

    errify(c.SDL_SetHint(c.SDL_HINT_RENDER_VSYNC, "1")) catch {};

    const window: *c.SDL_Window, const renderer: *c.SDL_Renderer = create_window_and_renderer: {
        var window: ?*c.SDL_Window = null;
        var renderer: ?*c.SDL_Renderer = null;
        try errify(c.SDL_CreateWindowAndRenderer("subhana Allah", window_w, window_h, c.SDL_WINDOW_RESIZABLE , &window, &renderer));
        errdefer comptime unreachable;

        break :create_window_and_renderer .{ window.?, renderer.? };
    };
    defer c.SDL_DestroyRenderer(renderer);
    defer c.SDL_DestroyWindow(window);

    // const font: *c.TTF_Font = open_font: {
    //     if(config.font_path) |path| blk: {
    //         break :open_font errify(c.TTF_OpenFont(path, 100)) catch break :blk;
    //     }
    //     const io: *c.SDL_IOStream = try errify(c.SDL_IOFromConstMem(font_data.ptr, font_data.len));
    //     break :open_font try errify(c.TTF_OpenFontIO(io, true, 100));
    // };
    const font: *c.TTF_Font = try errify(c.TTF_OpenFont("src/resources/Roboto-Regular.ttf", font_size));
    defer c.TTF_CloseFont(font);

    const text_engine = try errify(c.TTF_CreateRendererTextEngine(renderer));
    defer c.TTF_DestroyRendererTextEngine(text_engine);

    var fonts: [1]*c.TTF_Font = undefined; 
    fonts[0] = font;

    // Set up ClayRenderer
    var clay_renderer: clay_sdl_renderer.Clay_SDL3RendererData = .{
        .renderer = @ptrCast(renderer),
        .textEngine = @ptrCast(text_engine),
        .fonts = &fonts,
    };

    // const surface_image: *c.SDL_Surface = try errify(c.IMG_Load("/home/ibrahimo/in_the_name_of_allah.png"));
    const surface_image: *c.SDL_Surface = try errify(c.IMG_Load("src/resources/profile-picture.png"));
    defer c.SDL_DestroySurface(surface_image);

    clay.setDebugModeEnabled(true);

    // Main loop
    main_loop: while (true) {
        // Handle events
        var event: c.SDL_Event = undefined;
        while (c.SDL_PollEvent(&event)) {
            switch (event.type) {
                c.SDL_EVENT_QUIT => break :main_loop,
                c.SDL_EVENT_WINDOW_RESIZED => clay.setLayoutDimensions(.{ .w = @floatFromInt(event.window.data1), .h = @floatFromInt(event.window.data2) }),
                c.SDL_EVENT_MOUSE_MOTION => clay.setPointerState(.{ .x = event.motion.x, .y = event.motion.y }, 0 != (event.motion.state & c.SDL_BUTTON_LMASK)),
                c.SDL_EVENT_MOUSE_BUTTON_DOWN => clay.setPointerState(.{ .x = event.button.x, .y = event.button.y }, event.button.button == c.SDL_BUTTON_LEFT),
                c.SDL_EVENT_MOUSE_WHEEL => clay.updateScrollContainers(true, .{.x = event.wheel.x, .y = event.wheel.y}, 0.01),
                else => {},
            }
        }


        // var render_commands = createLayout(&profile_picture);
        var render_commands = createLayout(surface_image);

        try errify(c.SDL_SetRenderDrawColor(renderer, 0x47, 0x5b, 0x8d, 0xff));

        try errify(c.SDL_RenderClear(renderer));

        clay_sdl_renderer.SDL_Clay_RenderClayCommands(&clay_renderer, &render_commands);

        try errify(c.SDL_RenderPresent(renderer));
    }
}

/// Converts the return value of an SDL function to an error union.
inline fn errify(value: anytype) error{SdlError}!switch (@typeInfo(@TypeOf(value))) {
    .bool => void,
    .pointer, .optional => @TypeOf(value.?),
    .int => |info| switch (info.signedness) {
        .signed => @TypeOf(@max(0, value)),
        .unsigned => @TypeOf(value),
    },
    else => @compileError("unerrifiable type: " ++ @typeName(@TypeOf(value))),
} {
    return switch (@typeInfo(@TypeOf(value))) {
        .bool => if (!value) error.SdlError,
        .pointer, .optional => value orelse error.SdlError,
        .int => |info| switch (info.signedness) {
            .signed => if (value >= 0) @max(0, value) else error.SdlError,
            .unsigned => if (value != 0) value else error.SdlError,
        },
        else => comptime unreachable,
    };
}
