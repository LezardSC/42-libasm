#include "list.h"

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>

void test_strlen();
void test_strcpy();
void test_strcmp();
void test_write();
void test_read();
void test_strdup();
void test_atoi_base();
void test_list_push_front(list_t **begin_list);
void test_list_size();
void test_list_sort();

static void delete_test_file();
static void create_test_file();

int main() {
    list_t *list = NULL;
    create_test_file();

    test_strlen();
    test_strcpy();
    test_strcmp();
    test_write();
    test_read();
    test_strdup();
    test_atoi_base();
    test_list_push_front(&list);
    test_list_size();
    test_list_sort();
    delete_test_file();
    return 0;
}

static void create_test_file() {
    int fd = open("test_file.txt", O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd == -1) {
        perror("Error creating test file");
        exit(1);
    }

    const char *content = "Hello, this is a test file for ft_read!\n";
    write(fd, content, strlen(content));
    close(fd);
}

static void delete_test_file() {
    if (unlink("test_file.txt") == -1) {
        perror("Error deleting test file");
    }
}
