#include <stdio.h>
#include <stdlib.h>

#include "libecho/echo.h"
#include "libmatrix/matrix.h"

/**
 * Demo function, tests the matrix class
 * Expected output should be:
 * --------------------------
 * Test 1:
 * true
 *
 * Test 2:
 *  0.50   1.50  -2.00 	
 * -1.00   1.00  -1.00 	
 *  0.50  -1.50   2.00
 */
int main() {
    Matrix a = matrix_from(3, 3, (double[3][3]) {
        {1, 2, 2},
        {2, 1, 2},
        {2, 2, 1}
    });

    // Prove: A^2 - 4A - 5I(3) = O
    echo("Test 1:");
    Matrix lhs = ({
        Matrix a_sqr   = matrix_power(matrix_clone(a), 2);
        Matrix four_a  = matrix_scale(a, 4);
        Matrix diff    = matrix_subtract(a_sqr, four_a);
        Matrix i3      = matrix_mkunit(3);
        Matrix five_i3 = matrix_scale(i3, 5);
        Matrix res     = matrix_subtract(diff, five_i3);
        res;
    });
    Matrix rhs = matrix_mknull(3, 3);
    printf("%s\n\n", matrix_equals(lhs, rhs) ? "true" : "false");
    matrix_free(&lhs);
    matrix_free(&rhs);

    Matrix b = matrix_from(3, 3, (double[3][3]) {
        {1, 0, 1},
        {3, 4, 5},
        {2, 3, 4}
    });
    Matrix inv = matrix_inverse(b);
    echo("Test 2:");
    matrix_print(inv);
    matrix_free(&inv);

    return 0;
}
