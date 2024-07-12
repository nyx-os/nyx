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

  int pid = fork();

  if (pid == -1) {
    perror("fork");
    return EXIT_FAILURE;
  }

  if (pid == 0) {
    char *argv[] = {shell, NULL};
    execvp(shell, argv);
    return EXIT_FAILURE;
  }

  int status;
  waitpid(-1, &status, 0);

  return 0;
}
