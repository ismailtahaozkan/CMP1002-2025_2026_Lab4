// ============================================================================
// Lab: Destructors, Copy Constructors, and Default Memberwise Assignment
// Test File: test.cpp
// Framework: Catch2 v3 (amalgamated)
// ============================================================================
// Grading breakdown (100 points total):
//
//   CONSTRUCTOR TESTS          (15 pts)
//     - basic_construction       5 pts
//     - constructor_counter      5 pts
//     - empty_string_construct   5 pts
//
//   DESTRUCTOR TESTS            (15 pts)
//     - destructor_called        5 pts
//     - destructor_counter       5 pts
//     - multiple_destructions    5 pts
//
//   COPY CONSTRUCTOR TESTS      (25 pts)
//     - copy_has_same_data       7 pts
//     - copy_is_deep             8 pts
//     - copy_counter             5 pts
//     - copy_empty_string        5 pts
//
//   ASSIGNMENT OPERATOR TESTS   (25 pts)
//     - assignment_copies_data   7 pts
//     - assignment_is_deep       8 pts
//     - assignment_counter       5 pts
//     - self_assignment_safe     5 pts
//
//   SETDATA TESTS               (10 pts)
//     - setdata_changes_content  5 pts
//     - setdata_updates_length   5 pts
//
//   INTEGRATION TESTS           (10 pts)
//     - pass_by_value_triggers_copy  5 pts
//     - chain_assignment             5 pts
// ============================================================================

// Redirect student main so it doesn't conflict with Catch2's main
#define main student_main
#include "MainProgram.cpp"
#undef main

#include "catch_amalgamated.hpp"

// ============================================================================
// HELPER: Reset all counters before each test
// ============================================================================
struct CounterReset {
    CounterReset() { resetAllCounters(); }
};

// ============================================================================
// CONSTRUCTOR TESTS (15 points)
// ============================================================================

// [5 pts] Basic construction stores the correct string
TEST_CASE("basic_construction", "[constructor][5pts]") {
    CounterReset cr;
    DynamicBuffer buf("Hello");
    REQUIRE(std::string(buf.getData()) == "Hello");
    REQUIRE(buf.getLength() == 5);
}

// [5 pts] Constructor increments the global counter
TEST_CASE("constructor_counter", "[constructor][5pts]") {
    CounterReset cr;
    DynamicBuffer buf1("A");
    REQUIRE(getConstructorCount() == 1);
    DynamicBuffer buf2("B");
    REQUIRE(getConstructorCount() == 2);
}

// [5 pts] Constructing with an empty string works correctly
TEST_CASE("empty_string_construct", "[constructor][5pts]") {
    CounterReset cr;
    DynamicBuffer buf("");
    REQUIRE(std::string(buf.getData()) == "");
    REQUIRE(buf.getLength() == 0);
    REQUIRE(getConstructorCount() == 1);
}

// ============================================================================
// DESTRUCTOR TESTS (15 points)
// ============================================================================

// [5 pts] Destructor is called when object goes out of scope
TEST_CASE("destructor_called", "[destructor][5pts]") {
    CounterReset cr;
    {
        DynamicBuffer buf("Goodbye");
    }
    REQUIRE(getDestructorCount() >= 1);
}

// [5 pts] Destructor counter matches number of destroyed objects
TEST_CASE("destructor_counter", "[destructor][5pts]") {
    CounterReset cr;
    {
        DynamicBuffer buf1("A");
        DynamicBuffer buf2("B");
    }
    REQUIRE(getDestructorCount() == 2);
}

// [5 pts] Multiple scoped destructions are counted correctly
TEST_CASE("multiple_destructions", "[destructor][5pts]") {
    CounterReset cr;
    {
        DynamicBuffer buf1("X");
    }
    REQUIRE(getDestructorCount() == 1);
    {
        DynamicBuffer buf2("Y");
        DynamicBuffer buf3("Z");
    }
    REQUIRE(getDestructorCount() == 3);
}

// ============================================================================
// COPY CONSTRUCTOR TESTS (25 points)
// ============================================================================

// [7 pts] Copied object has the same data as the original
TEST_CASE("copy_has_same_data", "[copy_constructor][7pts]") {
    CounterReset cr;
    DynamicBuffer original("CopyMe");
    DynamicBuffer copied(original);
    REQUIRE(std::string(copied.getData()) == "CopyMe");
    REQUIRE(copied.getLength() == 6);
}

// [8 pts] Copy is deep - modifying original does not affect copy
TEST_CASE("copy_is_deep", "[copy_constructor][8pts]") {
    CounterReset cr;
    DynamicBuffer original("DeepTest");
    DynamicBuffer copied(original);

    // Pointers must be different (deep copy, not shallow)
    REQUIRE(original.getData() != copied.getData());

    // Modify original
    original.setData("Changed");
    REQUIRE(std::string(copied.getData()) == "DeepTest");
    REQUIRE(std::string(original.getData()) == "Changed");
}

// [5 pts] Copy constructor increments the global counter
TEST_CASE("copy_counter", "[copy_constructor][5pts]") {
    CounterReset cr;
    DynamicBuffer original("Count");
    REQUIRE(getCopyConstructorCount() == 0);
    DynamicBuffer copied(original);
    REQUIRE(getCopyConstructorCount() == 1);
}

// [5 pts] Copying an empty-string buffer works correctly
TEST_CASE("copy_empty_string", "[copy_constructor][5pts]") {
    CounterReset cr;
    DynamicBuffer original("");
    DynamicBuffer copied(original);
    REQUIRE(std::string(copied.getData()) == "");
    REQUIRE(copied.getLength() == 0);
    REQUIRE(original.getData() != copied.getData());
}

// ============================================================================
// ASSIGNMENT OPERATOR TESTS (25 points)
// ============================================================================

// [7 pts] Assignment copies data correctly
TEST_CASE("assignment_copies_data", "[assignment][7pts]") {
    CounterReset cr;
    DynamicBuffer a("Source");
    DynamicBuffer b("Target");
    b = a;
    REQUIRE(std::string(b.getData()) == "Source");
    REQUIRE(b.getLength() == 6);
}

// [8 pts] Assignment is deep - modifying source does not affect destination
TEST_CASE("assignment_is_deep", "[assignment][8pts]") {
    CounterReset cr;
    DynamicBuffer a("Original");
    DynamicBuffer b("Other");
    b = a;

    // Pointers must be different
    REQUIRE(a.getData() != b.getData());

    // Modify source after assignment
    a.setData("Modified");
    REQUIRE(std::string(b.getData()) == "Original");
    REQUIRE(std::string(a.getData()) == "Modified");
}

// [5 pts] Assignment operator increments the global counter
TEST_CASE("assignment_counter", "[assignment][5pts]") {
    CounterReset cr;
    DynamicBuffer a("X");
    DynamicBuffer b("Y");
    REQUIRE(getAssignmentCount() == 0);
    b = a;
    REQUIRE(getAssignmentCount() == 1);
}

// [5 pts] Self-assignment does not corrupt data or crash
TEST_CASE("self_assignment_safe", "[assignment][5pts]") {
    CounterReset cr;
    DynamicBuffer s("SelfTest");
    s = s;
    // Data must still be valid after self-assignment
    REQUIRE(std::string(s.getData()) == "SelfTest");
    REQUIRE(s.getLength() == 8);
}

// ============================================================================
// SETDATA TESTS (10 points)
// ============================================================================

// [5 pts] setData replaces the string content
TEST_CASE("setdata_changes_content", "[setdata][5pts]") {
    CounterReset cr;
    DynamicBuffer buf("Before");
    buf.setData("After");
    REQUIRE(std::string(buf.getData()) == "After");
}

// [5 pts] setData updates the length field correctly
TEST_CASE("setdata_updates_length", "[setdata][5pts]") {
    CounterReset cr;
    DynamicBuffer buf("Short");
    REQUIRE(buf.getLength() == 5);
    buf.setData("A much longer string now");
    REQUIRE(buf.getLength() == 24);
    buf.setData("");
    REQUIRE(buf.getLength() == 0);
}

// ============================================================================
// INTEGRATION TESTS (10 points)
// ============================================================================

// [5 pts] Passing by value triggers copy constructor
TEST_CASE("pass_by_value_triggers_copy", "[integration][5pts]") {
    CounterReset cr;
    DynamicBuffer original("PassByValue");
    int copyBefore = getCopyConstructorCount();
    DynamicBuffer result = createBufferCopy(original);
    // At least one copy should have been made (parameter pass)
    REQUIRE(getCopyConstructorCount() > copyBefore);
    REQUIRE(std::string(result.getData()) == "PassByValue");
}

// [5 pts] Chained assignment works (a = b = c)
TEST_CASE("chain_assignment", "[integration][5pts]") {
    CounterReset cr;
    DynamicBuffer a("A");
    DynamicBuffer b("B");
    DynamicBuffer c("ChainValue");
    a = b = c;
    REQUIRE(std::string(a.getData()) == "ChainValue");
    REQUIRE(std::string(b.getData()) == "ChainValue");
    REQUIRE(std::string(c.getData()) == "ChainValue");
    // All three should have independent memory
    REQUIRE(a.getData() != b.getData());
    REQUIRE(b.getData() != c.getData());
}
