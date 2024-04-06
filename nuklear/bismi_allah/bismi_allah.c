//in the name of Allah

#include <stdio.h>
#include <stdlib.h>

#include <SDL2/SDL.h>

#define NK_INCLUDE_FIXED_TYPES
#define NK_INCLUDE_STANDARD_IO
#define NK_INCLUDE_STANDARD_VARARGS
#define NK_INCLUDE_DEFAULT_ALLOCATOR
#define NK_INCLUDE_VERTEX_BUFFER_OUTPUT
#define NK_INCLUDE_FONT_BAKING
#define NK_INCLUDE_DEFAULT_FONT
#define NK_IMPLEMENTATION
#define NK_SDL_RENDERER_IMPLEMENTATION
#include "../Nuklear/nuklear.h"
#include "../Nuklear/demo/sdl_renderer/nuklear_sdl_renderer.h"

int main()
{
    int check = nk_true;
    printf("in the name of Allah\n");

    if(0 != SDL_Init(SDL_INIT_EVERYTHING))
    {
        printf("[SDL] error at init %s\n", SDL_GetError());
        exit(EXIT_FAILURE);
    }
    
    SDL_Window* window = SDL_CreateWindow("in the name of Allah", 100, 100, 800, 500, SDL_WINDOW_RESIZABLE);
    if(NULL == window)
    {
        SDL_Log("[SDL] error creating window %s\n", SDL_GetError());
        exit(EXIT_FAILURE);
    }
    SDL_Renderer* renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_PRESENTVSYNC);
    if (renderer == NULL)
    {
        SDL_Log("Error SDL_CreateRenderer %s", SDL_GetError());
        exit(-1);
    }

    struct nk_context* ctx;
    struct nk_colorf bg;

    ctx = nk_sdl_init(window, renderer);
    {
        struct nk_font_atlas* atlas;
        struct nk_font_config config = nk_font_config(0);
        struct nk_font* font;

        nk_sdl_font_stash_begin(&atlas);
        font = nk_font_atlas_add_default(atlas, 14, &config);

        nk_sdl_font_stash_end();
        nk_style_set_font(ctx, &font->handle);
    }

    struct nk_rect bismi_allah_rect = nk_rect(50, 50, 230, 250);
    int running = 1;
    while(1)
    {
        SDL_Event event;
        nk_input_begin(ctx);
        while(SDL_PollEvent(&event))
            {
            if(SDL_QUIT == event.type)
            {
                printf("inna li Allah\n");
                goto cleen_up;
            }
            nk_sdl_handle_event(&event);
        }
        nk_input_end(ctx);

        if(nk_begin(ctx, "in the name of Allah", nk_rect(50, 50, 80, 60), NK_WINDOW_BORDER | NK_WINDOW_MOVABLE | NK_WINDOW_SCALABLE | NK_WINDOW_MINIMIZABLE | NK_WINDOW_TITLE))
        {
            nk_layout_row_dynamic(ctx, 30, 1);
            if(nk_button_label(ctx, "bismi Allah 1"))
            {
                printf("[nk] pressed 'bismi Allah' button\n");
            }
        }nk_end(ctx);

        if(nk_begin(ctx, "in the name of Allah2", nk_rect(0, 0, 800, 600), NK_WINDOW_BORDER | NK_WINDOW_MOVABLE | NK_WINDOW_SCALABLE | NK_WINDOW_MINIMIZABLE | NK_WINDOW_TITLE))
        {
            /*
            nk_layout_row_dynamic(ctx, 50, 1);
            if(nk_button_label(ctx, "bismi Allah 1"))
            {
                printf("[nk] pressed 'bismi Allah' button\n");
            }
            */

            struct nk_rect total_space = nk_window_get_content_region(ctx);
            nk_layout_space_begin(ctx, NK_STATIC, total_space.h, 1);
            nk_layout_space_push(ctx, bismi_allah_rect);
            if(nk_group_begin(ctx, "in the name of Allah group1", NK_WINDOW_MOVABLE|NK_WINDOW_NO_SCROLLBAR|NK_WINDOW_BORDER|NK_WINDOW_TITLE))
            {
                nk_layout_row_dynamic(ctx, 0, 1);
                if(nk_button_label(ctx, "bismi Allah 1"))
                {
                    printf("[nk] pressed 'bismi Allah 1' button\n");
                }

                if(nk_button_label(ctx, "bismi Allah 2"))
                {
                    printf("[nk] pressed 'bismi Allah 2' button\n");
                }
            }
            nk_group_end(ctx);

            /*
            struct nk_input* input = &ctx->input;
            if(nk_input_is_mouse_hovering_rect(input, nk_layout_space_rect_to_screen(ctx, bismi_allah_rect))  && nk_input_is_mouse_down(input, NK_BUTTON_LEFT))
            {
                bismi_allah_rect.x += input->mouse.delta.x;
                bismi_allah_rect.y += input->mouse.delta.y;
            }
            */
            /*
            if (nk_input_mouse_clicked(input, NK_BUTTON_LEFT, nk_layout_space_bounds(ctx)))
            {
                printf("[nk] NK_BITTON_LEFT\n");
                bismi_allah_rect.x += input->mouse.delta.x;
                bismi_allah_rect.y += input->mouse.delta.y;
            }
            */

            nk_layout_space_end(ctx);
        }nk_end(ctx);

        //struct nk_window *bismi_allah_window = nk_window_find(ctx, "in the name of Allah2");

        int screen_width, screen_height;
        SDL_GetWindowSize(window, &screen_width, &screen_height);
        if(nk_begin(ctx, "in the name of Allah 3", nk_rect(10, 10, screen_width, 100), NK_WINDOW_BORDER | NK_WINDOW_MOVABLE | NK_WINDOW_SCALABLE | NK_WINDOW_MINIMIZABLE | NK_WINDOW_TITLE | NK_WINDOW_CLOSABLE))
        {
            nk_layout_row_dynamic(ctx, 25, 1);
            //nk_checkbox_text(ctx, "in the name of Allah", 100, &check);
            nk_checkbox_label(ctx, "in the name of Allah", &check);
            nk_layout_row_dynamic(ctx, 25, 1);
            if(nk_button_label(ctx, "بسم الله الرحمن الرحيم"))
            {
                nk_window_set_position(ctx, "in the name of Allah 3", nk_vec2(0, 0));
            }

            nk_layout_row_dynamic(ctx, 25, 1);
            if(nk_button_label(ctx, "la ilaha illa Allah mohammed rassoul Allah"))
            {
                nk_window_collapse(ctx, "in the name of Allah 3", nk_false);
            }
        }nk_end(ctx);

        if(nk_begin(ctx, "bismi allah rows", nk_rect(100, 100, 300, 300), NK_WINDOW_BORDER | NK_WINDOW_MOVABLE | NK_WINDOW_SCALABLE | NK_WINDOW_MINIMIZABLE | NK_WINDOW_TITLE | NK_WINDOW_CLOSABLE))
        {
            nk_layout_row_dynamic(ctx, 30, 1);
            nk_button_label(ctx, "la ilaha illa Allah 'dynamic'");

            nk_layout_row_static(ctx, 30, 200, 1);
            nk_button_label(ctx, "la ilaha illa Allah 'static'");
            nk_button_label(ctx, "la ilaha illa Allah");

            nk_layout_row_begin(ctx, NK_STATIC, 25, 2);

            nk_layout_row_push(ctx, 250);
            nk_button_label(ctx, "bismi_allah 'begin' static");
            nk_layout_row_push(ctx, 100);
            nk_button_label(ctx, "bismi_allah");

            nk_layout_row_begin(ctx, NK_DYNAMIC, 0, 2);
            
            nk_layout_row_push(ctx, 0.80f);
            nk_button_label(ctx, "bismi_allah 'begin' dynamic");
            nk_layout_row_push(ctx, 0.20f);
            nk_button_label(ctx, "bismi_allah");

            nk_layout_row_end(ctx);

            float ratio[] = {60, 40};
            nk_layout_row(ctx, NK_STATIC, 0, 1, ratio);
            nk_button_label(ctx, "bismi_allah");
            nk_button_label(ctx, "bismi_allah");
            nk_button_label(ctx, "bismi_allah");
            nk_button_label(ctx, "bismi_allah");

            ratio[0] = 0.75;
            ratio[1] = 0.25;
            nk_layout_row(ctx, NK_DYNAMIC, 0, 2, ratio);
            nk_button_label(ctx, "bismi_allah");
            nk_button_label(ctx, "bismi_allah");
            nk_button_label(ctx, "bismi_allah");
            nk_button_label(ctx, "bismi_allah");

            nk_layout_row_template_begin(ctx, 0);

            nk_layout_row_template_push_dynamic(ctx);
            nk_layout_row_template_push_variable(ctx, 100);
            nk_layout_row_template_push_static(ctx, 100);
            nk_layout_row_template_end(ctx);

            nk_button_label(ctx, "allah akbar");
            nk_button_label(ctx, "allah akbar");
            nk_button_label(ctx, "allah akbar");
            nk_button_label(ctx, "allah akbar");
            nk_button_label(ctx, "allah akbar");
            nk_button_label(ctx, "allah akbar");

        }
        nk_end(ctx);

        if(nk_begin(ctx, "bismi allah space", nk_rect(100, 100, 300, 300), NK_WINDOW_BORDER | NK_WINDOW_MOVABLE | NK_WINDOW_SCALABLE | NK_WINDOW_MINIMIZABLE | NK_WINDOW_TITLE | NK_WINDOW_CLOSABLE))
        {
            nk_layout_space_begin(ctx, NK_STATIC, 0, 20);
            nk_layout_space_push(ctx, nk_rect(0, 0, 200, 20));
            if(nk_button_label(ctx, "Allah is the greatest"))
            {
                printf("Allah is the greatest\n");
            }
            nk_layout_space_push(ctx, nk_rect(0, 20, 220, 20));
            if(nk_button_label(ctx, "la ilaha illa Allah"))
            {
                struct nk_rect rect = nk_layout_space_bounds(ctx);
                printf("alhamdo li Allah rect(%f, %f, %f, %f)\n", rect.x, rect.y, rect.h, rect.w);
            }
            nk_layout_space_end(ctx);

            nk_layout_space_begin(ctx, NK_DYNAMIC, 0, 10);
            nk_layout_space_push(ctx, nk_rect(0, 1, 1, 1));
            if(nk_button_label(ctx, "Allah akbar"))
            {
                struct nk_rect rect = nk_layout_space_bounds(ctx);
                printf("alhamdo li Allah rect(%f, %f, %f, %f)\n", rect.x, rect.y, rect.h, rect.w);
            }
            nk_layout_space_push(ctx, nk_rect(0, 2, 0.8, 1.5));
            if(nk_button_label(ctx, "Allah akbar"))
            {
                struct nk_rect rect = nk_layout_space_bounds(ctx);
                printf("alhamdo li Allah rect(%f, %f, %f, %f)\n", rect.x, rect.y, rect.h, rect.w);
            }
            nk_layout_space_end(ctx);
        }
        nk_end(ctx);

        if(nk_begin(ctx, "bismi_allah text/label", nk_rect(0, 0, 300, 100), NK_WINDOW_BORDER | NK_WINDOW_MOVABLE | NK_WINDOW_SCALABLE | NK_WINDOW_MINIMIZABLE | NK_WINDOW_TITLE | NK_WINDOW_CLOSABLE))
        {
            nk_layout_row_dynamic(ctx, 0, 1);
            //text
            nk_text(ctx, "bismi Allah text", 16, NK_TEXT_LEFT);
            nk_text(ctx, "bismi Allah text", 16, NK_TEXT_CENTERED);
            nk_text(ctx, "bismi Allah text", 16, NK_TEXT_RIGHT);

            struct nk_color bismi_allah_color_red = {255, 0, 0, 255};
            struct nk_color bismi_allah_color_yellow = {255, 255, 0, 255};
            struct nk_color bismi_allah_color_blue = {0, 0, 255, 255};
            nk_text_colored(ctx, "bismi Allah text", 16, NK_TEXT_LEFT, bismi_allah_color_yellow);
            nk_text_colored(ctx, "bismi Allah text", 16, NK_TEXT_CENTERED, bismi_allah_color_red);
            nk_text_colored(ctx, "bismi Allah text", 16, NK_TEXT_RIGHT, bismi_allah_color_blue);

            nk_text_wrap(ctx, "bismi Allah text", 16);
            nk_text_wrap_colored(ctx, "bismi Allah text", 16, bismi_allah_color_blue);

            //labels
            nk_label(ctx, "bismi Allah label", NK_TEXT_LEFT);
            nk_label(ctx, "bismi Allah label", NK_TEXT_CENTERED);
            nk_label(ctx, "bismi Allah label", NK_TEXT_RIGHT);

            nk_label_colored(ctx, "bismi Allah label", NK_TEXT_LEFT, bismi_allah_color_yellow);
            nk_label_colored(ctx, "bismi Allah label", NK_TEXT_CENTERED, bismi_allah_color_red);
            nk_label_colored(ctx, "bismi Allah label", NK_TEXT_RIGHT, bismi_allah_color_blue);

            nk_label_wrap(ctx, "bismi Allah label");
            nk_label_colored_wrap(ctx, "bismi Allah label", bismi_allah_color_blue);

            nk_labelf(ctx, NK_TEXT_CENTERED, "bismi_allah la ilaha illa Allah %d", 12);

            //value
            nk_value_bool(ctx, "bismi Allah", 0);
            nk_value_int(ctx, "bismi Allah", 0);
            nk_value_uint(ctx, "bismi Allah", 0);
            nk_value_float(ctx, "bismi Allah", 0);
            nk_value_color_byte(ctx, "bismi Allah", bismi_allah_color_yellow);
            nk_value_color_float(ctx, "bismi Allah", bismi_allah_color_yellow);
            nk_value_color_hex(ctx, "bismi Allah", bismi_allah_color_yellow);
        }
        nk_end(ctx);

        /*
        if(nk_begin(ctx, "bismi_allah menu", nk_rect(0, 0, 300, 100), NK_WINDOW_BORDER | NK_WINDOW_MOVABLE | NK_WINDOW_SCALABLE | NK_WINDOW_MINIMIZABLE | NK_WINDOW_TITLE | NK_WINDOW_CLOSABLE))
        {

        }
        nk_end(ctx);
        */

        SDL_SetRenderDrawColor(renderer, 100, 100, 100, 255);
        SDL_RenderClear(renderer);

        nk_sdl_render(NK_ANTI_ALIASING_ON);

        SDL_RenderPresent(renderer);
    }

cleen_up:
    nk_sdl_shutdown();
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    return 0;
}

