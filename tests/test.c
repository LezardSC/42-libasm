#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>

extern void test_strlen();
extern void test_strcpy();
extern void test_strcmp();
extern void test_write();
extern void test_read();
extern void test_strdup();

void create_test_file() {
    int fd = open("test_file.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd == -1) {
        perror("Error creating test file");
        exit(1);
    }

    const char *content = "Hello, this is a test file for ft_read!\n";
    write(fd, content, strlen(content));
    close(fd);
}

void delete_test_file() {
    if (unlink("test_file.txt") == -1) {
        perror("Error deleting test file");
    }
}

int main() {
    create_test_file();
    
    test_strlen();
    test_strcpy();
    test_strcmp();
    test_write();
    test_read();
    test_strdup();
    delete_test_file();
    return 0;
}