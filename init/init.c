#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <time.h>
#include <unistd.h>

const char *motds[] = {"Welcome to the NYX Operating System",
                       "Welcome to the Machine",
                       "It's a UNIX system, I know this!"};
const int margin = 50;

int main(void) {
  char *shell = getenv("SHELL");

  setenv("TERM", "linux", 1);
  setenv("USER", "root", 1);
  setenv("PATH", "/usr/local/bin:/usr/bin", 1);

  if (!shell) {
    return EXIT_FAILURE;
  }

  time_t rawtime;
  char timebuf[80];
  struct tm *timeinfo;

  time(&rawtime);
  timeinfo = localtime(&rawtime);

  strftime(timebuf, 80, "%a %b %d %H:%M:%S", timeinfo);

  srand(rawtime);
  printf("%s\n", motds[rand() % 2]);
  printf("Date/Time: %s\n", timebuf);
  printf("Launching shell %s\n", shell);

  puts("");

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
