# Lab: Destructors, Copy Constructors, and Default Memberwise Assignment

## Topic
Resource management in C++ — the Rule of Three: Destructors, Copy Constructors, and Copy Assignment Operators.

## Duration
60 minutes

## Learning Objectives
By completing this lab you will be able to:
1. Explain why classes that manage dynamic memory need custom destructors.
2. Implement a deep-copy constructor that creates an independent copy of heap-allocated data.
3. Implement a copy assignment operator with self-assignment protection.
4. Distinguish between shallow (memberwise) and deep copying.
5. Articulate the Rule of Three and recognise when it applies.

## Prerequisites
- Pointers and dynamic memory (`new` / `delete`)
- Basic class design (constructors, member functions)
- C-strings (`strlen`, `strcpy`)
- Scope and object lifetime

## File Structure
```
lab/
├── MainProgram.cpp          # Your working file (implement TODOs)
├── test.cpp                 # Catch2 test suite (do NOT modify)
├── catch_amalgamated.hpp    # Catch2 header (do NOT modify)
├── catch_amalgamated.cpp    # Catch2 source (do NOT modify)
├── Makefile                 # Build system
├── README.md                # This file
├── explain.txt              # Quick revision sheet
└── explain.md               # Detailed concept guide
```

## Instructions

### 1. Compile the main program
```bash
make
./MainProgram
```

### 2. Run the test suite
```bash
make test
```
This compiles and immediately runs all tests. Each test case is labelled with its point value.

### 3. Work through the TODOs
Open `MainProgram.cpp` and implement every section marked `// TODO`. The recommended order is:
1. **Parameterized Constructor** — allocate and copy the input string.
2. **Destructor** — free the allocated memory.
3. **setData** — replace the buffer with a new string.
4. **Copy Constructor** — deep-copy another buffer.
5. **Copy Assignment Operator** — deep-copy with self-assignment guard.

After each step, run `make test` to check your progress.

### 4. Verify with Valgrind (optional but recommended)
```bash
valgrind --leak-check=full ./MainProgram
valgrind --leak-check=full ./test_runner
```
A correct implementation should report **0 leaks**.

## Grading (100 points)

| Category               | Points | Test Cases                                       |
|------------------------|--------|--------------------------------------------------|
| Constructor            | 15     | basic_construction, constructor_counter, empty_string_construct |
| Destructor             | 15     | destructor_called, destructor_counter, multiple_destructions    |
| Copy Constructor       | 25     | copy_has_same_data, copy_is_deep, copy_counter, copy_empty_string |
| Assignment Operator    | 25     | assignment_copies_data, assignment_is_deep, assignment_counter, self_assignment_safe |
| setData                | 10     | setdata_changes_content, setdata_updates_length  |
| Integration            | 10     | pass_by_value_triggers_copy, chain_assignment     |
| **Total**              | **100**|                                                  |

## Submission
Submit only `MainProgram.cpp`. Do not modify or submit any other file.

## Common Mistakes
- **Forgetting `delete[]`** — causes memory leaks.
- **Using `delete` instead of `delete[]`** — undefined behaviour on arrays.
- **Shallow copy** — copying the pointer instead of the pointed-to data leads to double-free crashes.
- **Missing self-assignment check** — `a = a` will delete data before copying it, causing a crash or garbage.
- **Off-by-one in allocation** — always allocate `strlen + 1` to include the null terminator.
- **Not incrementing global counters** — tests rely on these to verify function calls.

## Academic Integrity
This lab is an individual assignment. You may discuss concepts with classmates but all code you submit must be your own. Do not copy from or share solutions with others. Plagiarism detection tools will be used.
