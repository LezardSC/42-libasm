#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

extern char *ft_strdup(const char *s);

void test_strdup() {
    const char *test_cases[] = {
        "Hello, world!",         
        "",                      
        "SingleChar",            
        "1234567890",            
        "\n\t",                  
        "This is a test!",
        "String with null\0byte",
        NULL                     
    };

    size_t num_tests = sizeof(test_cases) / sizeof(test_cases[0]);
    int all_pass = 1;

    for (size_t i = 0; i < num_tests; i++) {
        const char *input = test_cases[i];
        char *ft_result = NULL;
        char *std_result = NULL;

        errno = 0;
        if (input != NULL) {
            ft_result = ft_strdup(input);
        }
        int ft_errno = errno;

        errno = 0;
        if (input != NULL) {
            std_result = strdup(input);
        }
        int std_errno = errno;

        if ((input == NULL && ft_result == NULL && std_result == NULL) || 
            (input != NULL && ft_result != NULL && std_result != NULL && strcmp(ft_result, std_result) == 0)) {
            free(ft_result);
            free(std_result);
            continue;
        } else {
            all_pass = 0;
            printf("\033[1;31mFAIL\033[0m: ft_strdup(\"%s\")\n", input ? input : "NULL");
            printf("  ft_strdup: \"%s\", errno=%d\n", ft_result ? ft_result : "NULL", ft_errno);
            printf("   strdup: \"%s\", errno=%d\n", std_result ? std_result : "NULL", std_errno);
        }

        if (ft_result) free(ft_result);
        if (std_result) free(std_result);
    }

    if (all_pass) {
        printf("\033[1;32mPASS: All ft_strdup tests passed!\033[0m\n");
    }
}
