/* str.c: string library */

#include "str.h"

#include <ctype.h>
#include <stdbool.h>
#include <stdlib.h>

/* Functions */

/**
 * Convert string to lowercase.
 * @param   s	    String to convert
 * @param   w	    Pointer to buffer that holds result of conversion
 **/
void	str_lower(const char *s, char *w) {
    // TODO
}

/**
 * Convert string to uppercase.
 * @param   s	    String to convert
 * @param   w	    Pointer to buffer that holds result of conversion
 **/
void	str_upper(const char *s, char *w) {
    // TODO
}

/**
 * Convert string to titlecase.
 * @param   s	    String to convert
 * @param   w	    Pointer to buffer that holds result of conversion
 **/
void	str_title(const char *s, char *w) {
    // TODO
}

/**
 * Strip characters from back of string (if present).
 * @param   s	    String to strip
 * @param   chars   Characters to strip (if NULL, then all whitespace)
 * @param   w	    Pointer to buffer that holds result of strip
 **/
void	str_rstrip(const char *s, const char *chars, char *w) {
    // TODO
}

/**
 * Delete characters from string.
 * @param   s	    String to delete from
 * @param   chars   Characters to delete
 * @param   w	    Pointer to buffer that holds result of deletion
 **/
void	str_delete(const char *s, const char *chars, char *w) {
    // TODO
}

/**
 * Translate characters in 'from' with corresponding characters in 'to'.
 * @param   s       String to translate
 * @param   from    String with characters to translate
 * @param   to      String with corresponding translation characters
 * @param   w	    Pointer to buffer that holds result of translation
 **/
void	str_translate(const char *s, const char *from, const char *to, char *w) {
    // TODO
}

/* vim: set sts=4 sw=4 ts=8 expandtab ft=c: */
