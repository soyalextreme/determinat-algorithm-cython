from libc.stdio cimport printf
import random
import numpy as np

cdef list create_random_matrix(int size):
    cdef list m = []
    cdef int i
    cdef int n
    for i in range(size):
        m.append([])
        for _ in range(size):
            n = random.randint(1, 9)
            m[i].append(n)
    return m

cdef int print_matrix(list m):
    cdef list row
    cdef int n
    for row in m:
        printf("|")
        for n in row:
            printf(" %u ", n)
        printf("|\n")

cdef list transf_signs(list l, int row):
    cdef int i

    for i in range(len(l)):
        if (i + row) % 2 != 0:
            l[i] *= -1

    return l


cdef list reduce_matrix(list m, int best_row, int col_ignore):
    cdef reduced_matrix = []
    cdef int i 
    cdef int j
    for i in range(len(m[0])):
        if i == best_row:
            continue
        else:
            reduced_matrix.append([])
            for j in range(len(m[i])):
                if j != col_ignore:
                    reduced_matrix[i - 1].append(m[i][j])
    return reduced_matrix





cdef int determinat(list m):
    if len(m[0]) == 2:
        return (m[0][0] * m[1][1]) - (m[1][0] * m[0][1])
    
    cdef int best_row = 0

    # list with the signs transform
    cdef list l_trans = transf_signs(m[best_row], best_row)

    cdef list l_reduced_m = []

    cdef int i
    for i in range(len(l_trans)):
        l_reduced_m.append(reduce_matrix(m, best_row, i))

    cdef int result = 0

    for i in range(len(l_trans)):
        result += l_trans[i] * determinat(l_reduced_m[i])
    
    return result






cpdef int main():
    cdef size = int(input("Size of the matrix: "))
    cdef list m = create_random_matrix(size)
    # m2 = [[2,2], [2,2]]
    print_matrix(m)
    m_np = np.array(m)
    cdef int n = determinat(m)
    printf("|a| = %u ", n)
    r_np = np.linalg.det(m_np)
    print(r_np)
    return 0