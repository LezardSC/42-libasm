# LIBASM

libasm is an educational project from 42 School that involves re-implementing several standard C functions in **x86-64 assembly** using NASM. The goal is to gain a deeper understanding of **low-level programming**, **system calls**, and the **assembly language**.

## Features
This library reimplements the following functions:

### **Mandatory Part**
- `ft_strlen` - Computes the length of a string.
- `ft_strcpy` - Copies a string to a destination buffer.
- `ft_strcmp` - Compares two strings.
- `ft_write` - Writes data to a file descriptor using the `write` syscall.
- `ft_read` - Reads data from a file descriptor using the `read` syscall.
- `ft_strdup` - Duplicates a string dynamically using `malloc`.

### **Bonus Part**
- `ft_atoi_base` - Converts a string to an integer using a given base.
- `ft_list_push_front` - Adds an element at the beginning of a linked list.
- `ft_list_size` - Counts the number of elements in a linked list.
- `ft_list_sort` - Sorts a linked list using a comparison function.
- `ft_list_remove_if` - Removes elements from a linked list based on a given condition.

---

## **Installation & Compilation**
To compile the library, simply run:
```sh
make
```
This will generate `libasm.a`, which can be linked with other programs.

To compile with **bonus functions**, run:
```sh
make bonus
```

To clean object files:
```sh
make clean
```

To remove everything including compiled binaries:
```sh
make fclean
```

To recompile from scratch:
```sh
make re
```

---

## **Testing**
A set of test functions is included to validate the implementation. To compile and run the tests, execute:
```sh
make test
./test
```
For the **bonus functions**, use:
```sh
make test_bonus
./test_bonus
```

---

## **Implementation Details**
- **Assembly Syntax:** The project uses **NASM (Netwide Assembler)**.
- **System Calls:** `ft_write` and `ft_read` use the `syscall` instruction to interface with the Linux kernel.
- **Memory Management:** `ft_strdup` dynamically allocates memory using `malloc`, and proper error handling is implemented.
- **Makefile:** The project includes a robust **Makefile** that supports **dependency tracking, bonus compilation, and testing**.

---

## **Example Usage**
This project is a static library (`libasm.a`), which means you can link it with your own programs:

### **Compiling with libasm**
```sh
gcc -Wall -Wextra -Werror main.c libasm.a -o my_program
```

### **Example C Program Using libasm**
```c
#include <stdio.h>
#include "libasm.h"

int main() {
    char *s = "Hello, Assembly!";
    printf("Length: %zu\n", ft_strlen(s));
    return 0;
}
```

---

## **License**
This project is part of the **42 School curriculum** and follows its evaluation and submission guidelines.

---


Login: jrenault