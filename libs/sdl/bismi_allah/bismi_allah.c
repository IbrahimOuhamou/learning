//in the name of Allah

#include <stdio.h>
#include <SDL2/SDL.h>

int main()
{
    printf("in the name of Allah\n");

    SDL_Init(SDL_INIT_VIDEO);
    SDL_Window *window = SDL_CreateWindow("la ilaha illa Allah", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 1200, 800, SDL_WINDOW_SHOWN | SDL_WINDOW_RESIZABLE);
    if(NULL == window)
    {
        SDL_Log("Error SDL_CreateWindow() %s", SDL_GetError());
        exit(-1);
    }
    SDL_Renderer *renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_PRESENTVSYNC);
    if(NULL == renderer)
    {
        SDL_Log("Error SDL_CreateRenderer() %s", SDL_GetError());
        exit(-1);
    }

    SDL_Point bismi_allah_points[5];
    bismi_allah_points[0].x = 400;
    bismi_allah_points[0].y = 400;
    bismi_allah_points[1].x = 400;
    bismi_allah_points[1].y = 200;
    bismi_allah_points[2].x = 900;
    bismi_allah_points[2].y = 300;
    bismi_allah_points[3].x = 700;
    bismi_allah_points[3].y = 200;
    bismi_allah_points[4].x = 150;
    bismi_allah_points[4].y = 50;

    int running = 1;
    while(running)
    {
        SDL_Event event;
        while(SDL_PollEvent(&event))
        {
            switch(event.type)
            {
                case SDL_QUIT: running=0;break;
            }
        }

        SDL_SetRenderDrawColor(renderer, 0, 0, 0, 255);
        SDL_RenderClear(renderer);

        SDL_SetRenderDrawColor(renderer, 255, 255, 255, 255);
        SDL_RenderDrawLine(renderer, 0, 0, 100, 100);
        SDL_RenderDrawPoint(renderer, 400, 400);
        SDL_RenderDrawPoints(renderer, bismi_allah_points, 5);
        SDL_RenderDrawLines(renderer, bismi_allah_points, 5);

        SDL_RenderPresent(renderer);
    }

    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    SDL_Quit();
    return 0;
}

