#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>

extern ssize_t ft_read(int fd, void *buf, size_t count);

void test_read() {
    struct {
        int fd;
        size_t count;
        const char *desc;
    } test_cases[] = {
        {open("test_file.txt", O_RDONLY), 10, "Read 10 bytes from file"},
        {open("test_file.txt", O_RDONLY), 5, "Read 5 bytes from file"},
        {open("test_file.txt", O_RDONLY), 0, "Read 0 bytes from file"},
        {-1, 10, "Invalid FD"},
        {open("test_file.txt", O_RDONLY), 100, "Read beyond file size"}
    };

    size_t num_tests = sizeof(test_cases) / sizeof(test_cases[0]);
    int all_pass = 1;

    for (size_t i = 0; i < num_tests; i++) {
        char ft_buf[256] = {0};
        char std_buf[256] = {0};

        int fd = test_cases[i].fd;
        size_t count = test_cases[i].count;

        if (fd >= 0) {
            lseek(fd, 0, SEEK_SET);
        }

        errno = 0;
        ssize_t ft_result = ft_read(fd, ft_buf, count);
        int ft_errno = errno;

        if (fd >= 0) {
            lseek(fd, 0, SEEK_SET);
        }

        errno = 0;
        ssize_t std_result = read(fd, std_buf, count);
        int std_errno = errno;

        if (ft_result == std_result && ft_errno == std_errno &&
            (ft_result > 0 ? memcmp(ft_buf, std_buf, ft_result) == 0 : 1)) {
            if (fd >= 3) close(fd);
            continue;
        } else {
            all_pass = 0;
            printf("\033[1;31mFAIL\033[0m: %s\n", test_cases[i].desc);
            printf("  ft_read: result=%ld, errno=%d, buf=\"%.*s\"\n",
                   ft_result, ft_errno, (int)ft_result, ft_buf);
            printf("   read: result=%ld, errno=%d, buf=\"%.*s\"\n",
                   std_result, std_errno, (int)std_result, std_buf);
        }

        if (fd >= 3) close(fd);
    }

    if (all_pass) {
        printf("\033[1;32mPASS: All ft_read tests passed!\033[0m\n");
    }
}
