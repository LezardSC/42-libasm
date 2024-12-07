#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>

extern int ft_atoi_base(char *str, char *base);

void test_atoi_base() {
    struct {
        char *str;
        char *base;
        int expected;
        char *desc;
    } test_cases[] = {
        // Valid cases
        {"42", "0123456789", 42, "Decimal number in base 10"},
        {"-42", "0123456789", -42, "Negative decimal number in base 10"},
        {"   1010", "01", 10, "Binary number with leading spaces"},
        {"-1010", "01", -10, "Negative binary number"},
        {"1A", "0123456789ABCDEF", 26, "Hexadecimal number in base 16"},
        {"-1A", "0123456789ABCDEF", -26, "Negative hexadecimal number in base 16"},
        {"123", "012", 5, "Ternary number in base 3"},
        {"-1201", "012", -46, "Negative ternary number in base 3"},
        
        // Edge cases
        {"", "0123456789", 0, "Empty string"},
        {"42", "", 0, "Empty base"},
        {"42", "0", 0, "Base with a single character"},
        {"42", "01234567890", 0, "Base with duplicate characters"},
        {"42", "0123 ", 0, "Base with invalid whitespace"},
        {"42", "0123+", 0, "Base with invalid '+' character"},
        {"42", "0123-", 0, "Base with invalid '-' character"},
        {"++--42", "0123456789", 42, "Invalid string with multiple '+' signs"},
        {"---42", "0123456789", -42, "Invalid string with multiple '-' signs"},
        {"  - 42", "0123456789", 0, "Invalid string with space inside number"},
        {NULL, "0123456789", 0, "Null string"},
        {"42", NULL, 0, "Null base"},
        
        // Valid edge cases
        {"0", "0123456789", 0, "Zero in base 10"},
        {"-0", "0123456789", 0, "Negative zero in base 10"},
    };

    size_t num_tests = sizeof(test_cases) / sizeof(test_cases[0]);
    int all_pass = 1;

    for (size_t i = 0; i < num_tests; i++) {
        char *str = test_cases[i].str;
        char *base = test_cases[i].base;
        int expected = test_cases[i].expected;

        int result = ft_atoi_base(str, base);
        if (result == expected) {
            continue;
        } else {
            all_pass = 0;
            printf("\033[1;31mFAIL\033[0m: %s\n", test_cases[i].desc);
            printf("  ft_atoi_base(\"%s\", \"%s\") = %d (expected: %d)\n",
                   str ? str : "NULL", base ? base : "NULL", result, expected);
        }
    }

    if (all_pass) {
        printf("\033[1;32mPASS: All ft_atoi_base tests passed!\033[0m\n");
    }
}
