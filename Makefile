NAME					= libasm.a

BUILD_DIR				=	build/
DIR						=	src/
TEST_DIR				=	tests/

SRC						=	ft_strlen.s

TEST_SRC				=	test.c

TEST_EXEC				=	test_program

CC						=	gcc
CFLAGS					=	-Wall -Wextra -Werror


OBJECTS					= $(patsubst %.s, $(BUILD_DIR)%.o, $(SRC))

ASM						= nasm
ASMFLAGS				= -f elf64

RM						= rm -rf
CLEAR					= clear

$(BUILD_DIR)%.o :		$(DIR)%.s Makefile
						@mkdir -p $(shell dirname $@)
						$(ASM) $(ASMFLAGS) $< -o $@


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
test: 					$(NAME)
						$(CC) $(CFLAGS) -o $(TEST_EXEC) $(TEST_DIR)$(TEST_SRC) $(NAME)