// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah

const std = @import("std");

const c = @cImport({
    @cInclude("glad/gl.h");
    @cInclude("GLFW/glfw3.h");
});

var vertex_buffer_object: c.GLuint = undefined;
var vertex_array_object: c.GLuint = undefined;

var vertecies: [12]c.GLfloat = [_]c.GLfloat{
    -0.8, -0.8, -0.5,
    0.8,  -0.8, 0.0,
    0.0,  0.8,  0.0,
    0.0,  1.0,  0.0,
};

const vertex_shader_source =
    \\#version 460 core
    \\in vec3 aPos;
    \\void main() {
    \\  gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);
    \\};
;

const fragment_shader_source =
    \\#version 460 core
    \\out vec4 FragColor;
    \\void main() {
    \\  FragColor = vec4(1.0f, 0.5f, 0.2f, 1.0f);
    \\};
;

pub fn main() !void {
    std.debug.print("بسم الله الرحمن الرحيم\n", .{});

    if (c.glfwInit() == 0) {
        std.debug.panic("alhamod li Allah failed to init GLFW\n", .{});
    }
    defer c.glfwTerminate();

    c.glfwWindowHint(c.GLFW_CONTEXT_VERSION_MAJOR, 4);
    c.glfwWindowHint(c.GLFW_CONTEXT_VERSION_MINOR, 6);
    c.glfwWindowHint(c.GLFW_OPENGL_PROFILE, c.GLFW_OPENGL_CORE_PROFILE);
    c.glfwWindowHint(c.GLFW_OPENGL_FORWARD_COMPAT, c.GL_TRUE);

    const window = c.glfwCreateWindow(600, 300, "بسم الله الرحمن الرحيم", null, null);
    if (window == null) {
        std.debug.panic("alhamod li Allah failed to create GLFW window\n", .{});
    }
    defer c.glfwDestroyWindow(window);

    c.glfwMakeContextCurrent(window);
    _ = c.glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);

    if (c.gladLoadGL(c.glfwGetProcAddress) == 0) {
        std.debug.panic("alhamod li Allah failed to init GLAD\n", .{});
    }

    // triangle stuff
    var succes: c_int = undefined;
    var info_log_buffer: [512]u8 = undefined;

    const vertex_shader = c.glCreateShader(c.GL_VERTEX_SHADER);
    const vertex_shader_source_pointer: [*]const u8 = vertex_shader_source.ptr;
    c.glShaderSource(vertex_shader, 1, &vertex_shader_source_pointer, null);
    c.glCompileShader(vertex_shader);

    c.glGetShaderiv(vertex_shader, c.GL_COMPILE_STATUS, &succes);
    if (0 == succes) {
        c.glGetShaderInfoLog(vertex_shader, info_log_buffer.len, null, &info_log_buffer);
        std.debug.print("alahmdo li Allah error: '{s}'\n", .{info_log_buffer});
    }

    const fragment_shader = c.glCreateShader(c.GL_FRAGMENT_SHADER);
    const fragment_shader_source_pointer: [*]const u8 = fragment_shader_source.ptr;

    c.glShaderSource(fragment_shader, 1, &fragment_shader_source_pointer, null);
    c.glCompileShader(fragment_shader);

    c.glGetShaderiv(fragment_shader, c.GL_COMPILE_STATUS, &succes);
    if (0 == succes) {
        c.glGetShaderInfoLog(fragment_shader, info_log_buffer.len, null, &info_log_buffer);
        std.debug.print("alahmdo li Allah error: '{s}'\n", .{info_log_buffer});
    }

    const shader_program = c.glCreateProgram();
    c.glAttachShader(shader_program, vertex_shader);
    c.glAttachShader(shader_program, fragment_shader);
    c.glLinkProgram(shader_program);

    c.glGetShaderiv(shader_program, c.GL_LINK_STATUS, &succes);
    if (0 == succes) {
        c.glGetShaderInfoLog(shader_program, info_log_buffer.len, null, &info_log_buffer);
        std.debug.print("alahmdo li Allah error: '{s}'\n", .{info_log_buffer});
    }

    c.glDeleteShader(vertex_shader);
    c.glDeleteShader(fragment_shader);

    c.glGenVertexArrays(1, &vertex_array_object);
    c.glBindVertexArray(vertex_array_object);
    defer c.glBindVertexArray(0);

    c.glGenBuffers(1, &vertex_buffer_object);
    c.glBindBuffer(c.GL_ARRAY_BUFFER, vertex_buffer_object);
    c.glBufferData(c.GL_ARRAY_BUFFER, vertecies.len * @sizeOf(f32), &vertecies, c.GL_STATIC_DRAW);

    c.glEnableVertexAttribArray(0);
    defer c.glDisableVertexAttribArray(0);
    c.glVertexAttribPointer(0, 3, c.GL_FLOAT, c.GL_FALSE, 0, null);

    // render loop
    while (c.glfwWindowShouldClose(window) == 0) {
        // input
        processInput(window);

        // render
        c.glClearColor(0.2, 0.3, 0.3, 1.0);
        c.glClear(c.GL_COLOR_BUFFER_BIT);

        // triangle
        c.glUseProgram(shader_program);
        c.glBindVertexArray(vertex_array_object);

        c.glDrawArrays(c.GL_TRIANGLES, 0, vertecies.len / 3);

        // glfw: swap buffers and poll IO events (keys pressed/released, mouse moved etc.)
        c.glfwSwapBuffers(window);
        c.glfwPollEvents();
    }
}

// process all input: query GLFW whether relevant keys are pressed/released this frame and react accordingly
pub fn processInput(window: ?*c.GLFWwindow) callconv(.C) void {
    if (c.glfwGetKey(window, c.GLFW_KEY_ESCAPE) == c.GLFW_PRESS)
        c.glfwSetWindowShouldClose(window, 1);
}

// glfw: whenever the window size changed (by OS or user resize) this callback function executes
pub fn framebuffer_size_callback(window: ?*c.GLFWwindow, width: c_int, height: c_int) callconv(.C) void {
    _ = window;
    // make sure the viewport matches the new window dimensions; note that width and
    // height will be significantly larger than specified on retina displays.
    c.glViewport(0, 0, width, height);
}

fn createShaderProgram() c.GLuint {
    // const gl_program = c.glCreateProgram();
    // const vertex_shader = c.glCompileShader();
}
