#define _POSIX_C_SOURCE 200809L
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main(int argc, char **argv) {
  if (argc < 2) return 127;
  execvp("nix", argv + 1);  // replaces process with real nix
  perror("execvp nix failed");
  return 127;
}
