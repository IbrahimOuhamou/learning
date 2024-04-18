//in the name of Allah

#include <stdio.h>
#include <string.h>

int encrypt(char bismi_allah2[], char decalage2[]);
int decrypt(char bismi_allah2[], char decalage2[]);

int main()
{
    printf("in the name of Allah\n");

    /*
    int decalage = 7;
    char bismi_allah[] = "infrastructure\0";

    printf("bismi_allah_strlen = %d\n", strlen(bismi_allah));
    for(int i = 0; i<14; i++)
    {
        bismi_allah[i] += decalage;
        if(bismi_allah[i] > 'z')
        {
            bismi_allah[i] -= 26;
        }
    }
    printf("infrastructure -> '%s'\n", bismi_allah);
    */


    printf("z:%d\n", 'z');

    char bismi_allah2[] = "kolxebxkdvxsbtvirnrml";
    char decalage2[] = "parfait";

    decrypt(bismi_allah2, decalage2);
    printf("'%s'\n", bismi_allah2);
}

int encrypt(char bismi_allah2[], char decalage[])
{
    char decalage2[strlen(decalage)];
    for(int i=0; i<strlen(decalage); i++)
    {
        decalage2[i] = decalage[i];
    }

    int len = strlen(decalage2);
    int index = 0;
    for (int i=0; i<len; i++)
    {
        decalage2[i] -= 'a';
    }

    printf("'%s'\n", bismi_allah2);
    for (int i =0; i<strlen(bismi_allah2); i++)
    {
        if(' ' == bismi_allah2[i])
        {
            continue;
        }

        if(index >= len) index=0;
        
        bismi_allah2[i] += decalage2[index];
        index += 1;

        if(bismi_allah2[i] > 'z')
        {
            bismi_allah2[i] -= 26;
        }
    }
}

int decrypt(char bismi_allah2[], char decalage[])
{
    char decalage2[strlen(decalage)];
    for(int i=0; i<strlen(decalage); i++)
    {
        decalage2[i] = decalage[i];
    }

    int len = strlen(decalage2);
    int index = 0;
    for (int i=0; i<len; i++)
    {
        decalage2[i] -= 'a';
    }

    printf("'%s'\n", bismi_allah2);
    for (int i =0; i<strlen(bismi_allah2); i++)
    {
        if(' ' == bismi_allah2[i])
        {
            continue;
        }

        if(index >= len) index=0;
        
        bismi_allah2[i] -= decalage2[index];
        index += 1;

        if(bismi_allah2[i] < 'a')
        {
            bismi_allah2[i] += 26;
        }
    }
}

