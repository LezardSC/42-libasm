#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "list.h"

// Helper function to print the list (for debugging purposes)
void print_list(list_t *list);

// Declare your custom function
void ft_list_remove_if(list_t **begin_list, void *data_ref, int (*cmp)(void *, void *), void (*free_fct)(void *));

// Helper function to create a new list element
extern list_t *ft_list_create_elem(void *data);

// Helper function to free an element's data
void free_data(void *data) {
    // Assume data is dynamically allocated
    free(data);
}

// Helper function to compare two strings
int cmp_str(const char *a, const char *b);

// Test function
void test_list_remove_if() {
    list_t *list = NULL;

    // Case 1: Empty list
    ft_list_remove_if(&list, "Test", (int (*)(void *, void *))cmp_str, free_data);
    if (list != NULL) {
        printf("\033[1;31mFAIL\033[0m: Removing from an empty list should not change it.\n");
        return;
    }

    // Case 2: Removing an element that matches
    list = ft_list_create_elem(strdup("Test"));
    ft_list_remove_if(&list, "Test", (int (*)(void *, void *))cmp_str, free_data);
    if (list != NULL) {
        printf("\033[1;31mFAIL\033[0m: Failed to remove the only element in the list.\n");
        return;
    }

    // Case 3: Removing the first element in a list
    list = ft_list_create_elem(strdup("Test"));
    list->next = ft_list_create_elem(strdup("Keep"));
    ft_list_remove_if(&list, "Test", (int (*)(void *, void *))cmp_str, free_data);
    if (list == NULL || strcmp((char *)list->data, "Keep") != 0 || list->next != NULL) {
        printf("\033[1;31mFAIL\033[0m: Failed to remove the first element in the list.\n");
        return;
    }

    // Case 4: Removing the last element in a list
    list->next = ft_list_create_elem(strdup("Test"));
    ft_list_remove_if(&list, "Test", (int (*)(void *, void *))cmp_str, free_data);
    if (list == NULL || strcmp((char *)list->data, "Keep") != 0 || list->next != NULL) {
        printf("\033[1;31mFAIL\033[0m: Failed to remove the last element in the list.\n");
        return ;
    }

    // Case 5: Removing multiple elements
    list->next = ft_list_create_elem(strdup("Test"));
    list->next->next = ft_list_create_elem(strdup("Test"));
    list->next->next->next = ft_list_create_elem(strdup("Keep"));
    ft_list_remove_if(&list, "Test", (int (*)(void *, void *))cmp_str, free_data);

    // Check if the list now contains only "Keep" nodes (Keep -> Keep -> NULL)
    if (list == NULL || strcmp((char *)list->data, "Keep") != 0 || strcmp((char *)list->next->data, "Keep") != 0 || list->next->next != NULL) {
        printf("\033[1;31mFAIL\033[0m: Failed to remove multiple elements in the list.\n");
        return;
    }

    // Cleanup
    free_data(list->next->data);
    free(list->next);
    free_data(list->data);
    free(list);

    printf("\033[1;32mPASS: All ft_list_remove_if tests passed!\033[0m\n");
}