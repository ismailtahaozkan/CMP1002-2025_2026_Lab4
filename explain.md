# Destructors, Copy Constructors & Default Memberwise Assignment

## 1. Concept Overview

In C++, when a class manages a **dynamic resource** (memory allocated with `new`), the compiler-generated copy operations only duplicate the *pointer*, not the *data it points to*. This is called a **shallow copy** and leads to two objects sharing the same memory block. When one is destroyed, the other is left with a dangling pointer — a recipe for crashes and data corruption.

The **Rule of Three** states that if your class needs a custom version of *any one* of the following, it almost certainly needs *all three*:

1. **Destructor** — releases the resource.
2. **Copy Constructor** — creates a new object as an independent clone.
3. **Copy Assignment Operator** — replaces an existing object's data with a clone of another.

## 2. Key Concepts

- **Shallow Copy**: Only the pointer value is copied. Both objects point to the same heap memory. Dangerous.
- **Deep Copy**: New memory is allocated and the *content* is duplicated. Each object owns its own resource. Safe.
- **Destructor**: Automatically invoked when an object goes out of scope or is explicitly deleted. Responsible for cleanup.
- **Copy Constructor**: Invoked when a new object is initialised from an existing one, or when an object is passed/returned by value.
- **Copy Assignment Operator**: Invoked when an already-constructed object is assigned a new value from another object.
- **Self-Assignment Guard**: A check (`if (this == &other)`) at the start of `operator=` that prevents an object from freeing its own data before copying it.
- **Rule of Three**: If you define one of {destructor, copy constructor, copy assignment}, define all three.

## 3. Important Keywords

| Keyword | Explanation |
|---------|-------------|
| `new` / `new[]` | Allocates memory on the heap. Returns a pointer. |
| `delete` / `delete[]` | Frees heap memory. Must match `new` / `new[]`. |
| `strcpy` | Copies a C-string including the null terminator. |
| `strlen` | Returns the length of a C-string (excluding `\0`). |
| Dangling pointer | A pointer to memory that has already been freed. |
| Double free | Calling `delete` on the same memory twice — undefined behaviour. |
| `const ClassName&` | A constant reference parameter — prevents modification and avoids copying. |
| `*this` | A reference to the current object. Returned from `operator=` to allow chaining. |

## 4. Common Mistakes

- **Using `delete` instead of `delete[]` for arrays** — undefined behaviour; always match `new[]` with `delete[]`.
- **Forgetting the self-assignment check** — `obj = obj` will free the data and then try to read from freed memory.
- **Allocating `strlen(s)` instead of `strlen(s) + 1`** — forgets space for the null terminator `\0`.
- **Returning `void` from `operator=`** — breaks chaining (`a = b = c` won't compile).
- **Implementing only the destructor** — still leaves shallow copies via the default copy constructor and assignment operator.
- **Passing objects by value without realising it triggers a copy** — expensive and bug-prone if the copy constructor is wrong.

## 5. Mini Examples

### Destructor
```cpp
~DynamicBuffer() {
    delete[] m_data;   // free the array
}
```

### Copy Constructor
```cpp
DynamicBuffer(const DynamicBuffer& other) {
    m_length = other.m_length;
    m_data = new char[m_length + 1];   // allocate own memory
    strcpy(m_data, other.m_data);       // copy content
}
```

### Copy Assignment Operator
```cpp
DynamicBuffer& operator=(const DynamicBuffer& other) {
    if (this == &other) return *this;   // self-assignment guard
    delete[] m_data;                     // release old resource
    m_length = other.m_length;
    m_data = new char[m_length + 1];
    strcpy(m_data, other.m_data);
    return *this;                        // enable chaining
}
```

### Shallow vs Deep
```cpp
// SHALLOW (default — BAD for raw pointers)
m_data = other.m_data;   // both objects share memory

// DEEP (correct)
m_data = new char[other.m_length + 1];
strcpy(m_data, other.m_data);   // independent copy
```

## 6. When to Use This

- Any class that calls `new` or `new[]` in its constructor.
- Classes that wrap file handles, sockets, or GPU buffers.
- Implementing your own `String`, `Vector`, `Matrix`, or `Image` class.
- Whenever you see a **raw owning pointer** as a data member — that is the signal to apply the Rule of Three.
- In modern C++ (C++11+), you may instead use smart pointers (`std::unique_ptr`, `std::shared_ptr`) or the **Rule of Five** (adding move constructor and move assignment) — but understanding the Rule of Three is the foundation.
