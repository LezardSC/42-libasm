#include <stdio.h>
#include <string.h>

extern size_t ft_strlen(char* str);
extern char *ft_strcpy(char *dest, const char *src);
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

void test_strcpy() {
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
        char expected_dest[100];
        char ft_dest[100];

        strcpy(expected_dest, test_cases[i]);

        ft_strcpy(ft_dest, test_cases[i]);

        if (strcmp(expected_dest, ft_dest) != 0) {
            all_pass = 0;
            printf("\033[1;31mFAIL\033[0m: ft_strcpy(\"%s\") = \"%s\" (expected: \"%s\")\n",
                   test_cases[i], ft_dest, expected_dest);
        }
    }
    if (all_pass)
        printf("\033[1;32mPASS: All ft_strcpy tests passed!\033[0m\n");
}

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

int main() {
    test_strlen();
    test_strcpy();

    return 0;
}
