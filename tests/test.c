#include <stdio.h>

// Declare the assembly function
extern size_t ft_strlen(char* str);

int main() {
    char *str = "coucou";
    size_t size = ft_strlen(str);

    // Print the result
    printf("the size of %s is %ld\n", str, size);

    return 0;
}
