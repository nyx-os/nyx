#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <unistd.h>

int main(void) {

  char *shell = getenv("SHELL");

  if (!shell) {
    return EXIT_FAILURE;
  }

  while (true) {
    printf("Welcome to \033[1;32mnyx\033[0m, your shell is %s\n", shell);

    int pid = fork();

    if (pid == -1) {
      perror("fork");
      return EXIT_FAILURE;
    }

    if (pid == 0) {
      char *argv[] = {shell, NULL};
      execvp(shell, argv);
      return EXIT_FAILURE;
    } else {
      int status;
      waitpid(pid, &status, 0);
    }
  }

  return 0;
}