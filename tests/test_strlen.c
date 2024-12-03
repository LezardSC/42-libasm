#include <stdio.h>
#include <string.h>

extern size_t ft_strlen(char* str);

void test_strlen() {
    char *test_cases[] = {
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
        size_t expected_length = strlen(test_cases[i]);
        size_t result = ft_strlen(test_cases[i]);

        if (result == expected_length) {
            continue;
        } else {
            all_pass = 0;
            printf("\033[1;31mFAIL\033[0m: ft_strlen(\"%s\") = %ld (expected: %ld)\n",
                   test_cases[i], result, expected_length);
        }
    }
    if (all_pass)
        printf("\033[1;32mPASS: All ft_strlen tests passed!\033[0m\n");
}