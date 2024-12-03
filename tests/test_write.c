#include <string.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>

extern ssize_t ft_write(int fd, const void *buf, size_t count);

void test_write() {
    struct {
        int fd;
        const char *buf;
        size_t count;
    } test_cases[] = {
        {1, "Hello, world!\n", 14},
        {1, "Short\n", 6},
        {1, "", 0},
        {2, "Error output\n", 13},
        {-1, "Invalid FD\n", 11},
        {1, NULL, 5},
    };

    size_t num_tests = sizeof(test_cases) / sizeof(test_cases[0]);
    int all_pass = 1;

    for (size_t i = 0; i < num_tests; i++) {
        int fd = test_cases[i].fd;
        const char *buf = test_cases[i].buf;
        size_t count = test_cases[i].count;

        errno = 0;
        ssize_t ft_result = ft_write(fd, buf, count);
        int ft_errno = errno;

        errno = 0;
        ssize_t std_result = write(fd, buf, count);
        int std_errno = errno;

        if (ft_result == std_result && ft_errno == std_errno) {
            continue;
        } else {
            all_pass = 0;
            printf("\033[1;31mFAIL\033[0m: ft_write(fd=%d, buf=\"%s\", count=%lu)\n",
                   fd, buf ? buf : "NULL", count);
            printf("      ft_write: result=%ld, errno=%d\n", ft_result, ft_errno);
            printf("       write: result=%ld, errno=%d\n", std_result, std_errno);
        }
    }

    if (all_pass) {
        printf("\033[1;32mPASS: All ft_write tests passed!\033[0m\n");
    }
}