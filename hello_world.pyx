def say_hello(name):
    print("Hello %s!"%name)
    print("Im from cython")

cdef float weight_mars(int mass):
    cdef float gravity = 3.71
    return mass * gravity 

cpdef int main():
    cpdef float w = weight_mars(60)
    print(w)


