const std = @import("std");
const cl = @import("zclay");
const math = std.math;

const c = @cImport({
    @cDefine("SDL_DISABLE_OLD_NAMES", {});
    @cInclude("SDL3/SDL.h");
    @cInclude("SDL3/SDL_revision.h");
    @cDefine("SDL_MAIN_HANDLED", {});
    @cInclude("SDL3/SDL_main.h");
    @cInclude("SDL3_ttf/SDL_ttf.h");
    @cInclude("SDL3_image/SDL_image.h");
});

// Define the renderer data struct
pub const Clay_SDL3RendererData = struct {
    renderer: *c.SDL_Renderer,
    textEngine: *c.TTF_TextEngine,
    fonts: []*c.TTF_Font,
};

// Constants
const NUM_CIRCLE_SEGMENTS = 16;
const MAX_CIRCLE_SEGMENTS = 256;
const MAX_VERTICES = 4 + (4 * (MAX_CIRCLE_SEGMENTS * 2)) + 2 * 4; // 2060
const MAX_INDICES = 6 + (4 * (MAX_CIRCLE_SEGMENTS * 3)) + 6 * 4;   // 3102
const MAX_ARC_POINTS = 1024;

// Post-increment helper function
fn postIncrement(num: *u32) u32 {
    const current = num.*;
    num.* += 1;
    return current;
}

// Render a filled rounded rectangle
pub fn SDL_Clay_RenderFillRoundedRect(
    rendererData: *Clay_SDL3RendererData,
    rect: c.SDL_FRect,
    corner_radius: f32,
    _color: cl.Color,
) void {
    // Convert Clay color to SDL_FColor
    const color = c.SDL_FColor{
        .r = _color[0] / 255.0,
        .g = _color[1] / 255.0,
        .b = _color[2] / 255.0,
        .a = _color[3] / 255.0,
    };

    // Initialize counters
    var vertexCount: u32 = 0;
    var indexCount: u32 = 0;

    // Calculate radius constraints
    const minRadius = @min(rect.w, rect.h) / 2.0;
    const clampedRadius = @min(corner_radius, minRadius);
    const numCircleSegments = @max(
        NUM_CIRCLE_SEGMENTS,
        @as(u32, @intFromFloat(clampedRadius * 0.5)),
    );

    // Define arrays with maximum sizes
    var vertices: [MAX_VERTICES]c.SDL_Vertex = undefined;
    var indices: [MAX_INDICES]c_int = undefined;

    // Center rectangle vertices
    vertices[vertexCount] = c.SDL_Vertex{
        .position = .{ .x = rect.x + clampedRadius, .y = rect.y + clampedRadius },
        .color = color,
        .tex_coord = .{ .x = 0, .y = 0 },
    };
    vertexCount += 1;

    vertices[vertexCount] = c.SDL_Vertex{
        .position = .{ .x = rect.x + rect.w - clampedRadius, .y = rect.y + clampedRadius },
        .color = color,
        .tex_coord = .{ .x = 1, .y = 0 },
    };
    vertexCount += 1;

    vertices[vertexCount] = c.SDL_Vertex{
        .position = .{ .x = rect.x + rect.w - clampedRadius, .y = rect.y + rect.h - clampedRadius },
        .color = color,
        .tex_coord = .{ .x = 1, .y = 1 },
    };
    vertexCount += 1;

    vertices[vertexCount] = c.SDL_Vertex{
        .position = .{ .x = rect.x + clampedRadius, .y = rect.y + rect.h - clampedRadius },
        .color = color,
        .tex_coord = .{ .x = 0, .y = 1 },
    };
    vertexCount += 1;

    // Center rectangle indices (two triangles: 0-1-3 and 1-2-3)
    indices[indexCount] = 0;
    indexCount += 1;
    indices[indexCount] = 1;
    indexCount += 1;
    indices[indexCount] = 3;
    indexCount += 1;
    indices[indexCount] = 1;
    indexCount += 1;
    indices[indexCount] = 2;
    indexCount += 1;
    indices[indexCount] = 3;
    indexCount += 1;

    // Rounded corners as triangle fans
    const step = (c.SDL_PI_F / 2.0) / @as(f32, @floatFromInt(numCircleSegments));
    for (0..numCircleSegments) |i| {
        const angle1 = @as(f32, @floatFromInt(i)) * step;
        const angle2 = (@as(f32, @floatFromInt(i)) + 1.0) * step;

        for (0..4) |j| {
            const cx = switch (j) {
                0, 3 => rect.x + clampedRadius,
                1, 2 => rect.x + rect.w - clampedRadius,
                else => unreachable,
            };
            const cy = switch (j) {
                0, 1 => rect.y + clampedRadius,
                2, 3 => rect.y + rect.h - clampedRadius,
                else => unreachable,
            };
            const signX: f32 = if (j == 0 or j == 3) -1.0 else 1.0;
            const signY: f32 = if (j == 0 or j == 1) -1.0 else 1.0;

            vertices[vertexCount] = c.SDL_Vertex{
                .position = .{
                    .x = cx + c.SDL_cosf(angle1) * clampedRadius * signX,
                    .y = cy + c.SDL_sinf(angle1) * clampedRadius * signY,
                },
                .color = color,
                .tex_coord = .{ .x = 0, .y = 0 },
            };
            vertexCount += 1;

            vertices[vertexCount] = c.SDL_Vertex{
                .position = .{
                    .x = cx + c.SDL_cosf(angle2) * clampedRadius * signX,
                    .y = cy + c.SDL_sinf(angle2) * clampedRadius * signY,
                },
                .color = color,
                .tex_coord = .{ .x = 0, .y = 0 },
            };
            vertexCount += 1;

            indices[indexCount] = @as(c_int, @intCast(j));
            indexCount += 1;
            indices[indexCount] = @as(c_int, @intCast(vertexCount - 2));
            indexCount += 1;
            indices[indexCount] = @as(c_int, @intCast(vertexCount - 1));
            indexCount += 1;
        }
    }

    // Edge rectangles
    // Top edge
    vertices[vertexCount] = c.SDL_Vertex{
        .position = .{ .x = rect.x + clampedRadius, .y = rect.y },
        .color = color,
        .tex_coord = .{ .x = 0, .y = 0 },
    };
    vertexCount += 1;
    vertices[vertexCount] = c.SDL_Vertex{
        .position = .{ .x = rect.x + rect.w - clampedRadius, .y = rect.y },
        .color = color,
        .tex_coord = .{ .x = 1, .y = 0 },
    };
    vertexCount += 1;
    indices[indexCount] = 0;
    indexCount += 1;
    indices[indexCount] = @as(c_int, @intCast(vertexCount - 2));
    indexCount += 1;
    indices[indexCount] = @as(c_int, @intCast(vertexCount - 1));
    indexCount += 1;
    indices[indexCount] = 1;
    indexCount += 1;
    indices[indexCount] = 0;
    indexCount += 1;
    indices[indexCount] = @as(c_int, @intCast(vertexCount - 1));
    indexCount += 1;

    // Right edge
    vertices[vertexCount] = c.SDL_Vertex{
        .position = .{ .x = rect.x + rect.w, .y = rect.y + clampedRadius },
        .color = color,
        .tex_coord = .{ .x = 1, .y = 0 },
    };
    vertexCount += 1;
    vertices[vertexCount] = c.SDL_Vertex{
        .position = .{ .x = rect.x + rect.w, .y = rect.y + rect.h - clampedRadius },
        .color = color,
        .tex_coord = .{ .x = 1, .y = 1 },
    };
    vertexCount += 1;
    indices[indexCount] = 1;
    indexCount += 1;
    indices[indexCount] = @as(c_int, @intCast(vertexCount - 2));
    indexCount += 1;
    indices[indexCount] = @as(c_int, @intCast(vertexCount - 1));
    indexCount += 1;
    indices[indexCount] = 2;
    indexCount += 1;
    indices[indexCount] = 1;
    indexCount += 1;
    indices[indexCount] = @as(c_int, @intCast(vertexCount - 1));
    indexCount += 1;

    // Bottom edge
    vertices[vertexCount] = c.SDL_Vertex{
        .position = .{ .x = rect.x + rect.w - clampedRadius, .y = rect.y + rect.h },
        .color = color,
        .tex_coord = .{ .x = 1, .y = 1 },
    };
    vertexCount += 1;
    vertices[vertexCount] = c.SDL_Vertex{
        .position = .{ .x = rect.x + clampedRadius, .y = rect.y + rect.h },
        .color = color,
        .tex_coord = .{ .x = 0, .y = 1 },
    };
    vertexCount += 1;
    indices[indexCount] = 2;
    indexCount += 1;
    indices[indexCount] = @as(c_int, @intCast(vertexCount - 2));
    indexCount += 1;
    indices[indexCount] = @as(c_int, @intCast(vertexCount - 1));
    indexCount += 1;
    indices[indexCount] = 3;
    indexCount += 1;
    indices[indexCount] = 2;
    indexCount += 1;
    indices[indexCount] = @as(c_int, @intCast(vertexCount - 1));
    indexCount += 1;

    // Left edge
    vertices[vertexCount] = c.SDL_Vertex{
        .position = .{ .x = rect.x, .y = rect.y + rect.h - clampedRadius },
        .color = color,
        .tex_coord = .{ .x = 0, .y = 1 },
    };
    vertexCount += 1;
    vertices[vertexCount] = c.SDL_Vertex{
        .position = .{ .x = rect.x, .y = rect.y + clampedRadius },
        .color = color,
        .tex_coord = .{ .x = 0, .y = 0 },
    };
    vertexCount += 1;
    indices[indexCount] = 3;
    indexCount += 1;
    indices[indexCount] = @as(c_int, @intCast(vertexCount - 2));
    indexCount += 1;
    indices[indexCount] = @as(c_int, @intCast(vertexCount - 1));
    indexCount += 1;
    indices[indexCount] = 0;
    indexCount += 1;
    indices[indexCount] = 3;
    indexCount += 1;
    indices[indexCount] = @as(c_int, @intCast(vertexCount - 1));
    indexCount += 1;

    // Render the geometry
    _ = c.SDL_RenderGeometry(
        rendererData.renderer,
        null,
        &vertices[0],
        @as(c_int, @intCast(vertexCount)),
        &indices[0],
        @as(c_int, @intCast(indexCount)),
    );
}

// Render an arc
pub fn SDL_Clay_RenderArc(
    rendererData: *Clay_SDL3RendererData,
    center: c.SDL_FPoint,
    radius: f32,
    startAngle: f32,
    endAngle: f32,
    thickness: f32,
    color: cl.Color,
) void {
    _ = c.SDL_SetRenderDrawColorFloat(rendererData.renderer, color[0], color[1], color[2], color[3]);

    const radStart = startAngle * (c.SDL_PI_F / 180.0);
    const radEnd = endAngle * (c.SDL_PI_F / 180.0);
    const numCircleSegments = @max(
        NUM_CIRCLE_SEGMENTS,
        @as(i32, @intFromFloat(radius * 1.5)),
    );
    const angleStep = (radEnd - radStart) / @as(f32, @floatFromInt(numCircleSegments));
    const thicknessStep: f32 = 0.4;

    var points: [MAX_ARC_POINTS]c.SDL_FPoint = undefined;
    if (numCircleSegments + 1 > MAX_ARC_POINTS) {
        std.log.err("Arc exceeds maximum points: {}", .{numCircleSegments + 1});
        return;
    }

    var t = thicknessStep;
    while (t < thickness - thicknessStep) : (t += thicknessStep) {
        const clampedRadius = @max(radius - t, 1.0);
        for (0..@as(usize, @intCast(numCircleSegments + 1))) |i| {
            const angle = radStart + @as(f32, @floatFromInt(i)) * angleStep;
            points[i] = c.SDL_FPoint{
                .x = c.SDL_roundf(center.x + c.SDL_cosf(angle) * clampedRadius),
                .y = c.SDL_roundf(center.y + c.SDL_sinf(angle) * clampedRadius),
            };
        }
        _ = c.SDL_RenderLines(
            rendererData.renderer,
            &points[0],
            numCircleSegments + 1,
        );
    }
}

// Render Clay commands
pub fn SDL_Clay_RenderClayCommands(
    rendererData: *Clay_SDL3RendererData,
    rcommands: *cl.ClayArray(cl.RenderCommand),
) void {
    for (0..rcommands.length) |i| {
        const rcmd = cl.renderCommandArrayGet(rcommands, @intCast(i));
        const bounding_box = rcmd.bounding_box;
        const rect = c.SDL_FRect{
            .x = bounding_box.x,
            .y = bounding_box.y,
            .w = bounding_box.width,
            .h = bounding_box.height,
        };

        switch (rcmd.command_type) {
            .rectangle => {
                const config = rcmd.render_data.rectangle;
                _ = c.SDL_SetRenderDrawBlendMode(rendererData.renderer, c.SDL_BLENDMODE_BLEND);
                _ = c.SDL_SetRenderDrawColorFloat(
                    rendererData.renderer,
                    config.background_color[0],
                    config.background_color[1],
                    config.background_color[2],
                    config.background_color[3],
                );
                if (config.corner_radius.top_left > 0) {
                    SDL_Clay_RenderFillRoundedRect(
                        rendererData,
                        rect,
                        config.corner_radius.top_left,
                        config.background_color,
                    );
                } else {
                    _ = c.SDL_RenderFillRect(rendererData.renderer, &rect);
                }
            },
            .text => {
                const config = rcmd.render_data.text;
                const font = rendererData.fonts[config.font_id];
                const text = c.TTF_CreateText(
                    rendererData.textEngine,
                    font,
                    config.string_contents.chars,
                    @intCast(config.string_contents.length),
                );
                if (text != null) {
                    _ = c.TTF_SetTextColorFloat(
                        text,
                        config.text_color[0],
                        config.text_color[1],
                        config.text_color[2],
                        config.text_color[3],
                    );
                    _ = c.TTF_DrawRendererText(text, rect.x, rect.y);
                    c.TTF_DestroyText(text);
                }
            },
            .border => {
                const config = rcmd.render_data.border;
                const minRadius = @min(rect.w, rect.h) / 2.0;
                const clampedRadii = cl.CornerRadius{
                    .top_left = @min(config.corner_radius.top_left, minRadius),
                    .top_right = @min(config.corner_radius.top_right, minRadius),
                    .bottom_left = @min(config.corner_radius.bottom_left, minRadius),
                    .bottom_right = @min(config.corner_radius.bottom_right, minRadius),
                };

                _ = c.SDL_SetRenderDrawColorFloat(
                    rendererData.renderer,
                    config.color[0],
                    config.color[1],
                    config.color[2],
                    config.color[3],
                );

                // Left edge
                if (config.width.left > 0) {
                    const starting_y = rect.y + clampedRadii.top_left;
                    const length = rect.h - clampedRadii.top_left - clampedRadii.bottom_left;
                    const line = c.SDL_FRect{
                        .x = rect.x,
                        .y = starting_y,
                        .w = @as(f32, @floatFromInt(config.width.left)),
                        .h = length,
                    };
                    _ = c.SDL_RenderFillRect(rendererData.renderer, &line);
                }

                // Right edge
                if (config.width.right > 0) {
                    const starting_x = rect.x + rect.w - @as(f32, @floatFromInt(config.width.right));
                    const starting_y = rect.y + clampedRadii.top_right;
                    const length = rect.h - clampedRadii.top_right - clampedRadii.bottom_right;
                    const line = c.SDL_FRect{
                        .x = starting_x,
                        .y = starting_y,
                        .w = @as(f32, @floatFromInt(config.width.right)),
                        .h = length,
                    };
                    _ = c.SDL_RenderFillRect(rendererData.renderer, &line);
                }

                // Top edge
                if (config.width.top > 0) {
                    const starting_x = rect.x + clampedRadii.top_left;
                    const length = rect.w - clampedRadii.top_left - clampedRadii.top_right;
                    const line = c.SDL_FRect{
                        .x = starting_x,
                        .y = rect.y,
                        .w = length,
                        .h = @as(f32, @floatFromInt(config.width.top)),
                    };
                    _ = c.SDL_RenderFillRect(rendererData.renderer, &line);
                }

                // Bottom edge
                if (config.width.bottom > 0) {
                    const starting_x = rect.x + clampedRadii.bottom_left;
                    const starting_y = rect.y + rect.h - @as(f32, @floatFromInt(config.width.bottom));
                    const length = rect.w - clampedRadii.bottom_left - clampedRadii.bottom_right;
                    const line = c.SDL_FRect{
                        .x = starting_x,
                        .y = starting_y,
                        .w = length,
                        .h = @as(f32, @floatFromInt(config.width.bottom)),
                    };
                    _ = c.SDL_RenderFillRect(rendererData.renderer, &line);
                }

                // Corners
                if (config.corner_radius.top_left > 0) {
                    const center = c.SDL_FPoint{
                        .x = rect.x + clampedRadii.top_left - 1,
                        .y = rect.y + clampedRadii.top_left,
                    };
                    SDL_Clay_RenderArc(
                        rendererData,
                        center,
                        clampedRadii.top_left,
                        180.0,
                        270.0,
                        @as(f32, @floatFromInt(config.width.top)),
                        config.color,
                    );
                }
                if (config.corner_radius.top_right > 0) {
                    const center = c.SDL_FPoint{
                        .x = rect.x + rect.w - clampedRadii.top_right - 1,
                        .y = rect.y + clampedRadii.top_right,
                    };
                    SDL_Clay_RenderArc(
                        rendererData,
                        center,
                        clampedRadii.top_right,
                        270.0,
                        360.0,
                        @as(f32, @floatFromInt(config.width.top)),
                        config.color,
                    );
                }
                if (config.corner_radius.bottom_left > 0) {
                    const center = c.SDL_FPoint{
                        .x = rect.x + clampedRadii.bottom_left - 1,
                        .y = rect.y + rect.h - clampedRadii.bottom_left - 1,
                    };
                    SDL_Clay_RenderArc(
                        rendererData,
                        center,
                        clampedRadii.bottom_left,
                        90.0,
                        180.0,
                        @as(f32, @floatFromInt(config.width.bottom)),
                        config.color,
                    );
                }
                if (config.corner_radius.bottom_right > 0) {
                    const center = c.SDL_FPoint{
                        .x = rect.x + rect.w - clampedRadii.bottom_right - 1,
                        .y = rect.y + rect.h - clampedRadii.bottom_right - 1,
                    };
                    SDL_Clay_RenderArc(
                        rendererData,
                        center,
                        clampedRadii.bottom_right,
                        0.0,
                        90.0,
                        @as(f32, @floatFromInt(config.width.bottom)),
                        config.color,
                    );
                }
            },
            .scissor_start => {
                const clipRect = c.SDL_Rect{
                    .x = @intFromFloat(bounding_box.x),
                    .y = @intFromFloat(bounding_box.y),
                    .w = @intFromFloat(bounding_box.width),
                    .h = @intFromFloat(bounding_box.height),
                };
                _ = c.SDL_SetRenderClipRect(rendererData.renderer, &clipRect);
            },
            .scissor_end => {
                _ = c.SDL_SetRenderClipRect(rendererData.renderer, null);
            },
            .image => {
                // const image = @as(*c.SDL_Surface, rcmd.render_data.image.image_data);
                const image: *c.SDL_Surface = @alignCast(@ptrCast(rcmd.render_data.image.image_data));
                const texture = c.SDL_CreateTextureFromSurface(rendererData.renderer, image);
                if (texture != null) {
                    _ = c.SDL_RenderTexture(rendererData.renderer, texture, null, &rect);
                    c.SDL_DestroyTexture(texture);
                }
            },
            else => {
                std.log.warn("Unknown render command type: {}", .{rcmd.command_type});
            },
        }
    }
}
