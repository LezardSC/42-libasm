#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "list.h"

extern void	ft_list_sort(list_t **begin_list, int (*cmp)(void *, void *));
extern void ft_list_push_front(list_t **begin_list, void *data);

// Helper function to compare two strings
int cmp_str(const char *a, const char *b) {
    return strcmp(a, b);
}

// Helper function to print the list (for debugging purposes)
void print_list(list_t *list) {
    while (list) {
        if (list->data)
            printf("%s -> ", (char *)list->data);
        else
            printf("NULL -> ");
        list = list->next;
    }
    printf("NULL\n");
}

// Helper function to free the list
void free_list(list_t **list);

// Test function
void test_list_sort() {
    list_t *list = NULL;

    // Case 1: Sorting an empty list
    ft_list_sort(&list, (int (*)(void *, void *))cmp_str);
    if (list != NULL) {
        printf("\033[1;31mFAIL\033[0m: Sorting an empty list should not change it.\n");
        return;
    }

    // Case 2: Sorting a list with one element
    ft_list_push_front(&list, "Alpha");
    ft_list_sort(&list, (int (*)(void *, void *))cmp_str);
    if (list == NULL || strcmp((char *)list->data, "Alpha") != 0 || list->next != NULL) {
        printf("\033[1;31mFAIL\033[0m: Sorting a single-element list failed.\n");
        return;
    }
    free_list(&list);
    list = NULL;

    // Case 3: Sorting an already sorted list
    ft_list_push_front(&list, "Beta");
    ft_list_push_front(&list, "Alpha");
    ft_list_sort(&list, (int (*)(void *, void *))cmp_str);
    if (list == NULL || strcmp((char *)list->data, "Alpha") != 0 || strcmp((char *)list->next->data, "Beta") != 0 || list->next->next != NULL) {
        printf("\033[1;31mFAIL\033[0m: Sorting an already sorted list failed.\n");
        return;
    }
    free_list(&list);
    list = NULL;

    // Case 4: Sorting a list with multiple elements in reverse order
    free_list(&list);
    ft_list_push_front(&list, "Charlie");
    ft_list_push_front(&list, "Beta");
    ft_list_push_front(&list, "Alpha");
    ft_list_sort(&list, (int (*)(void *, void *))cmp_str);
    if (list == NULL || strcmp((char *)list->data, "Alpha") != 0 ||
        strcmp((char *)list->next->data, "Beta") != 0 ||
        strcmp((char *)list->next->next->data, "Charlie") != 0 || list->next->next->next != NULL) {
        printf("\033[1;31mFAIL\033[0m: Sorting a reverse-ordered list failed.\n");
        return;
    }
    free_list(&list);
    list = NULL;

    // Case 5: Sorting a list with duplicate elements
    free_list(&list);
    ft_list_push_front(&list, "Beta");
    ft_list_push_front(&list, "Alpha");
    ft_list_push_front(&list, "Beta");
    ft_list_sort(&list, (int (*)(void *, void *))cmp_str);
    if (list == NULL || strcmp((char *)list->data, "Alpha") != 0 ||
        strcmp((char *)list->next->data, "Beta") != 0 ||
        strcmp((char *)list->next->next->data, "Beta") != 0 || list->next->next->next != NULL) {
        printf("\033[1;31mFAIL\033[0m: Sorting a list with duplicate elements failed.\n");
        return;
    }
    free_list(&list);
    list = NULL;

    // Cleanup
    printf("\033[1;32mPASS: All ft_list_sort tests passed!\033[0m\n");
}