#include <stdio.h>
#include <string.h>

extern char *ft_strcpy(char *dest, const char *src);

void test_strcpy() {
    const char *test_cases[] = {
        "hello",
        "coucou",
        "",
        "A",
        "This is a test!",
        "1234567890",
        "\n\t",
        "very long string example to test",
    };

    int all_pass = 1;
    size_t num_tests = sizeof(test_cases) / sizeof(test_cases[0]);

    for (size_t i = 0; i < num_tests; i++) {
        char expected_dest[100];
        char ft_dest[100];

        char *expected_result = strcpy(expected_dest, test_cases[i]);

        char *ft_result = ft_strcpy(ft_dest, test_cases[i]);

        if (strcmp(expected_dest, ft_dest) == 0 && expected_result == expected_dest && ft_result == ft_dest) {
            continue;
        } else {
            all_pass = 0;
            printf("\033[1;31mFAIL\033[0m: ft_strcpy(\"%s\")\n", test_cases[i]);
            printf("      ft_strcpy result: \"%s\", returned: %p\n", ft_dest, (void *)ft_result);
            printf("       strcpy result: \"%s\", returned: %p\n", expected_dest, (void *)expected_result);
        }
    }

    if (all_pass) {
        printf("\033[1;32mPASS: All ft_strcpy tests passed!\033[0m\n");
    }
}