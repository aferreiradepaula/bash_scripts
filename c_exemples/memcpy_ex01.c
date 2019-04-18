#include <stdio.h>
#include <string.h>

/* gcc -g memcpy_ex01.c -o memcpy_ex01.exe */

int main() {
  int MAX_TAM_STRING = 10;

  char input_str[MAX_TAM_STRING];
  char str_aux[MAX_TAM_STRING];
  char *output_str;

  strncpy(input_str, "12345", MAX_TAM_STRING);
  printf("input_str: %s\n", input_str);

  /* Reset string */
  memset(input_str, '\0', sizeof( input_str ));

  strncpy(input_str, "123456", 2);
  printf("input_str: %s\n", input_str);

  /* Reset string */
  memset(str_aux, '\0', sizeof( str_aux ));
  output_str = strncpy(str_aux, "1234567890123456", MAX_TAM_STRING-1);

  printf("input_str: %s\n", str_aux);
  printf("output_str: %s\n", output_str);

  return 0;
}
