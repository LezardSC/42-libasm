#include <string.h>
#include <stdio.h>

extern int ft_strcmp(const char *s1, const char *s2);

void test_strcmp() {
    struct {
        char *s1;
        char *s2;
    } test_cases[] = {
        {"hello", "hello"},
        {"coucou", "coucou"},
        {"abc", "abd"},
        {"abd", "abc"},
        {"", ""},
        {"a", ""},
        {"", "a"},
        {"test", "testing"},
        {"testing", "test"},
        {"12345", "1234"},
    };
     int all_pass = 1;
    size_t num_tests = sizeof(test_cases) / sizeof(test_cases[0]);

    for (size_t i = 0; i < num_tests; i++) {
        int expected_result = strcmp(test_cases[i].s1, test_cases[i].s2);
        int result = ft_strcmp(test_cases[i].s1, test_cases[i].s2);

        if ((expected_result < 0 && result < 0) ||
            (expected_result == 0 && result == 0) ||
            (expected_result > 0 && result > 0)) {
            continue;
        } else {
            all_pass = 0;
            printf("\033[1;31mFAIL\033[0m: ft_strcmp(\"%s\", \"%s\") = %d (expected: %d)\n",
                   test_cases[i].s1, test_cases[i].s2, result, expected_result);
        }
    }

    if (all_pass)
        printf("\033[1;32mPASS: All ft_strcmp tests passed!\033[0m\n");
}