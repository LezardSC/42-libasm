#include "libft_add_ons.h"

#include <stdbool.h>
#include <stdlib.h>

static bool     is_space(char c);
static bool     is_base_valid(char *base, size_t len_base);
static int      get_sign(char *str);
static char     *skip_spaces(char *str);
static char     *skip_signs(char *str);
static int      convert_base(char *str, char *base, size_t len_base);
static ssize_t  get_base_value(char c, char *base);

int ft_atoi_base(char *str, char *base) {
	if (str == NULL || base == NULL) {
		return (0);
	}

	size_t len_base = ft_strlen(base);
	int sign = get_sign(str);

	if (!is_base_valid(base, len_base)) {
		return (0);
	}
	str = skip_spaces(str);
	str = skip_signs(str);

	int result = convert_base(str, base, len_base);

	return (result * sign);
}

static bool is_space(const char c) {
	return (c == ' ' || c == '\t'
		|| c == '\n' || c == '\v'
		|| c == '\f' || c == '\r');
}

static bool is_base_valid(char *base, size_t len_base) {
	if (len_base <= 1) {
		return (false);
	}
	for (size_t i = 0; i < len_base; i++) {
		if (is_space(base[i]) || base[i] == '+' || base[i] == '-') {
			return (false);
		}
		for (size_t j = i + 1; j < len_base; j++) {
			if (base[i] == base[j]) {
				return (false);
			}
		}
	}
	return (true);
}

static int get_sign(char *str) {
	int sign = 1;

	while (is_space(str[0])) {
		str++;
	}
	while (str[0] == '+' || str[0] == '-') {
		if (str[0] == '-') {
			sign *= -1;
		}
		str++;
	}
	return (sign);
}

static char *skip_spaces(char *str) {
	while (is_space(str[0])) {
		str++;
	}
	return (str);
}

static char *skip_signs(char *str) {
	while (str[0] == '-' || str[0] == '+') {
		str++;
	}
	return (str);
}

static int convert_base(char *str, char *base, size_t len_base) {
	int result = 0;
	ssize_t base_value;

	for (size_t i = 0; str[i]; i++) {
		base_value = get_base_value(str[i], base);
		if (base_value == -1) {
			return (result);
		}
		result = result * len_base + base_value;
	}
	return (result);
}

static ssize_t get_base_value(char c, char *base) {
	for (size_t i = 0; base[i]; i++) {
		if (base[i] == c) {
			return (i);
		}
	}
	return (-1);
}