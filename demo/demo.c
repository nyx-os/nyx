#include <stdbool.h>
#include <stdio.h>
#include <time.h>
#include <unistd.h>

int main(void) {
  time_t rawtime;

  struct tm *timeinfo;

  time(&rawtime);
  timeinfo = localtime(&rawtime);

  printf("%s\n", asctime(timeinfo));

  return 0;
}
