//in the name of Allah

#include <stdio.h>
#include <stdint.h>

int main()
{
    printf("in the name of Allah\n");

    int arr[100];
    for(int i = 0; i< sizeof(arr)/sizeof(arr[0]); ++i)
    {
        arr[i] = i;
    }

    FILE* file = fopen("bismi_allah", "wb");
    fwrite(arr, sizeof(arr[0]), sizeof(arr)/sizeof(arr[0]), file);
    fclose(file);

    int8_t arr2[100];
    file = fopen("bismi_allah", "rb");
    fread(arr2, sizeof(arr2[0]), sizeof(arr2)/sizeof(arr2[0]), file);
    fclose(file);


    for(int8_t i = 0; i < sizeof(arr2)/sizeof(arr2[0]); i++)
    {
        printf("%d : %d\n", arr[i], arr2[i]);
    }

}


