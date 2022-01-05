For those who feel like compiling something, create file temp.c with the following:

Make a file called ```temp.c```, add the following to the file:


```
#include <stdio.h>

int main(int argc, char *argv[]) 
{
   FILE *fp;

   int temp = 0;
   fp = fopen("/sys/class/thermal/thermal_zone0/temp", "r");
   fscanf(fp, "%d", &temp);
   printf(">> CPU Temp: %.2f°C\n", temp / 1000.0);
   fclose(fp);

   return 0;
}
```

Compile with:

```
gcc temp.c -o temp
```

Then copy to directory in your path:

```
sudo mv ./temp /usr/local/bin/
```

Run from anywhere:

```
aturfer@pi4:~$ temp
>> CPU Temp: 42.35°C
```