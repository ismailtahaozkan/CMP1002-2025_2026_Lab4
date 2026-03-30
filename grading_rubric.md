# Grading Rubric — Destructors, Copy Constructors & Assignment Lab

**Total: 100 points**

---

## Constructor Tests (15 points)

| Test Name                | Points | What It Checks                                      |
|--------------------------|--------|-----------------------------------------------------|
| `basic_construction`     | 5      | Stores the correct string and length                |
| `constructor_counter`    | 5      | Increments `g_constructorCount` each time           |
| `empty_string_construct` | 5      | Handles empty string `""` without crashing          |

---

## Destructor Tests (15 points)

| Test Name                | Points | What It Checks                                      |
|--------------------------|--------|-----------------------------------------------------|
| `destructor_called`      | 5      | Destructor runs when object leaves scope            |
| `destructor_counter`     | 5      | Counter matches number of destroyed objects         |
| `multiple_destructions`  | 5      | Correct count across multiple scopes                |

---

## Copy Constructor Tests (25 points)

| Test Name                | Points | What It Checks                                      |
|--------------------------|--------|-----------------------------------------------------|
| `copy_has_same_data`     | 7      | Copied object holds identical string and length     |
| `copy_is_deep`           | 8      | Different pointers; modifying original doesn't affect copy |
| `copy_counter`           | 5      | Increments `g_copyConstructorCount`                 |
| `copy_empty_string`      | 5      | Deep copy works for empty string                    |

---

## Assignment Operator Tests (25 points)

| Test Name                | Points | What It Checks                                      |
|--------------------------|--------|-----------------------------------------------------|
| `assignment_copies_data` | 7      | Assigned object holds correct string and length     |
| `assignment_is_deep`     | 8      | Different pointers; modifying source doesn't affect target |
| `assignment_counter`     | 5      | Increments `g_assignmentCount`                      |
| `self_assignment_safe`   | 5      | `obj = obj` does not crash or corrupt data          |

---

## setData Tests (10 points)

| Test Name                | Points | What It Checks                                      |
|--------------------------|--------|-----------------------------------------------------|
| `setdata_changes_content`| 5      | Buffer content updates to new string                |
| `setdata_updates_length` | 5      | `m_length` reflects the new string's length         |

---

## Integration Tests (10 points)

| Test Name                     | Points | What It Checks                                  |
|-------------------------------|--------|-------------------------------------------------|
| `pass_by_value_triggers_copy` | 5      | Pass-by-value invokes copy constructor          |
| `chain_assignment`            | 5      | `a = b = c` works; all hold independent copies  |

---

## Summary

| Category            | Points |
|---------------------|--------|
| Constructor         | 15     |
| Destructor          | 15     |
| Copy Constructor    | 25     |
| Assignment Operator | 25     |
| setData             | 10     |
| Integration         | 10     |
| **Total**           | **100**|
