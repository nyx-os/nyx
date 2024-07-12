#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void) {
  char *shell = getenv("SHELL");

  setenv("TERM", "linux", 1);
  setenv("USER", "root", 1);
  setenv("PATH", "/usr/local/bin:/usr/bin", 1);

  if (!shell) {
    return EXIT_FAILURE;
  }

  printf("Welcome to \033[32mnyx\033[0m, your shell is %s\n", shell);

  char string[] = "hello";
  char using_lots_of_stack[16384];

  memset(using_lots_of_stack, 0, 16384);

  if (!fork()) {
    printf("fork 1\n");
    string[0] = 'B';

    if (!fork()) {
      printf("fork 2\n");
      string[0] = 'C';
      if (!fork()) {
        printf("fork 3\n");
        string[0] = 'D';
        memset(using_lots_of_stack, 0x69, 16384);
        exit(0);
      }
      memset(using_lots_of_stack, 0xcc, 16384);
      exit(0);
    }

    exit(0);
  }

  int status;
  waitpid(-1, &status, 0);

  for (int i = 0; i < 16384; i++) {
    if (using_lots_of_stack[i] != 0)
      printf("%p: %x", &using_lots_of_stack[i], using_lots_of_stack[i]);
  }

  printf("forked process exited: %s\n", string);

  return 0;
}
