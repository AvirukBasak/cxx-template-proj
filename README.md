# CXX Template Project

**Deprecated Template**: Please use CMake.

This is a single makefile based project template for C/C++.

It also takes into account presence of external libraries as dependencies.
Do note that if external libraries are included in `src/lib*`, makefile will need modification for each library.

### Directory structure
```
project/
├── include/
│   ├── lib1/
│   │   ├── header1.h
│   │   └── header2.h
│   ├── lib2/
│   │   ├── header1.h
│   │   └── header2.h
│   ├── header1.h
│   └── header2.h
├── src/
│   ├── lib1/
│   │   ├── source1.c
│   │   └── source2.c
│   ├── lib2/
│   │   ├── source1.c
│   │   └── source2.c
│   ├── main.c
│   ├── module1.c
│   └── module2.c
├── lib/
│   ├── lib1.a
│   └── lib2.a
├── obj/
│   ├── lib1/
│   ├── lib2/
│   ├── main.o
│   ├── module1.o
│   └── module2.o
└── Makefile
```
