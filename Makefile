NAME					= libasm.a

BUILD_DIR				=	build/
DIR						=	src/
TEST_DIR				=	tests/

SRC						=	ft_strlen.s \
							ft_strcpy.s \
							ft_strcmp.s \
							ft_write.s \
							ft_read.s \
							ft_strdup.s

TEST_SRC				=	test.c \
							test_strcmp.c \
							test_strlen.c \
							test_strcpy.c \
							test_write.c \
							test_read.c \
							test_strdup.c

TEST_EXEC				=	test

CC						=	gcc
CFLAGS					=	-Wall -Wextra -Werror


OBJECTS					= $(patsubst %.s, $(BUILD_DIR)%.o, $(SRC))
TEST_OBJECTS 			= $(patsubst %.c, $(BUILD_DIR)%.o, $(TEST_SRC))

ASM						= nasm
ASMFLAGS				= -f elf64

RM						= rm -rf
CLEAR					= clear

$(BUILD_DIR)%.o :		$(DIR)%.s Makefile
						@mkdir -p $(shell dirname $@)
						$(ASM) $(ASMFLAGS) $< -o $@

$(BUILD_DIR)%.o :		$(TEST_DIR)%.c
						@mkdir -p $(shell dirname $@)
						$(CC) $(CFLAGS) -c $< -o $@

.PHONY: all
all: clear
	$(MAKE) $(NAME)

.PHONY: clear
clear:
						$(CLEAR)
						
$(NAME):				 $(OBJECTS)
						rm -rf $(NAME)
						ar rcs $(NAME) $(OBJECTS)

.PHONY: clean
clean:
						@${RM} $(BUILD_DIR)

.PHONY: fclean
fclean:					clean
						@${RM} ${NAME}
						@$(RM) $(TEST_EXEC)

.PHONY: re
re:						fclean
						$(MAKE) all

.PHONY: test
test: 					$(NAME) $(TEST_OBJECTS)
						$(CC) $(CFLAGS) -o $(TEST_EXEC) $(TEST_OBJECTS) $(NAME)