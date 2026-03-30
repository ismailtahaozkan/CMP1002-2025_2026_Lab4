CXX      = g++
CXXFLAGS = -Wall --std=c++17
TARGET   = MainProgram
TEST_BIN = test_runner

MAIN_SRC  = MainProgram.cpp
TEST_SRC  = test.cpp
CATCH_SRC = catch_amalgamated.cpp

.PHONY: all test clean grade \
        test-constructor test-destructor test-copy test-assignment \
        test-setdata test-integration test-one \
        test-basic_construction test-constructor_counter test-empty_string_construct \
        test-destructor_called test-destructor_counter test-multiple_destructions \
        test-copy_has_same_data test-copy_is_deep test-copy_counter test-copy_empty_string \
        test-assignment_copies_data test-assignment_is_deep test-assignment_counter test-self_assignment_safe \
        test-setdata_changes_content test-setdata_updates_length \
        test-pass_by_value_triggers_copy test-chain_assignment

# =============================================================================
# BUILD
# =============================================================================

all: $(TARGET)

$(TARGET): $(MAIN_SRC)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(MAIN_SRC)

$(TEST_BIN): $(TEST_SRC) $(CATCH_SRC) $(MAIN_SRC)
	$(CXX) $(CXXFLAGS) -o $(TEST_BIN) $(TEST_SRC) $(CATCH_SRC)

# =============================================================================
# RUN ALL TESTS
# =============================================================================

test: $(TEST_BIN)
	./$(TEST_BIN) --success

# =============================================================================
# RUN BY CATEGORY
# =============================================================================

test-constructor: $(TEST_BIN)
	./$(TEST_BIN) [constructor] --success

test-destructor: $(TEST_BIN)
	./$(TEST_BIN) [destructor] --success

test-copy: $(TEST_BIN)
	./$(TEST_BIN) [copy_constructor] --success

test-assignment: $(TEST_BIN)
	./$(TEST_BIN) [assignment] --success

test-setdata: $(TEST_BIN)
	./$(TEST_BIN) [setdata] --success

test-integration: $(TEST_BIN)
	./$(TEST_BIN) [integration] --success

# =============================================================================
# RUN BY NAME (generic)
# Usage: make test-one NAME="basic_construction"
# =============================================================================

test-one: $(TEST_BIN)
	./$(TEST_BIN) "$(NAME)" --success

# =============================================================================
# INDIVIDUAL TEST TARGETS  (one per rubric line)
# =============================================================================

# --- Constructor (15 pts) ---
test-basic_construction: $(TEST_BIN)
	./$(TEST_BIN) "basic_construction" --success

test-constructor_counter: $(TEST_BIN)
	./$(TEST_BIN) "constructor_counter" --success

test-empty_string_construct: $(TEST_BIN)
	./$(TEST_BIN) "empty_string_construct" --success

# --- Destructor (15 pts) ---
test-destructor_called: $(TEST_BIN)
	./$(TEST_BIN) "destructor_called" --success

test-destructor_counter: $(TEST_BIN)
	./$(TEST_BIN) "destructor_counter" --success

test-multiple_destructions: $(TEST_BIN)
	./$(TEST_BIN) "multiple_destructions" --success

# --- Copy Constructor (25 pts) ---
test-copy_has_same_data: $(TEST_BIN)
	./$(TEST_BIN) "copy_has_same_data" --success

test-copy_is_deep: $(TEST_BIN)
	./$(TEST_BIN) "copy_is_deep" --success

test-copy_counter: $(TEST_BIN)
	./$(TEST_BIN) "copy_counter" --success

test-copy_empty_string: $(TEST_BIN)
	./$(TEST_BIN) "copy_empty_string" --success

# --- Assignment Operator (25 pts) ---
test-assignment_copies_data: $(TEST_BIN)
	./$(TEST_BIN) "assignment_copies_data" --success

test-assignment_is_deep: $(TEST_BIN)
	./$(TEST_BIN) "assignment_is_deep" --success

test-assignment_counter: $(TEST_BIN)
	./$(TEST_BIN) "assignment_counter" --success

test-self_assignment_safe: $(TEST_BIN)
	./$(TEST_BIN) "self_assignment_safe" --success

# --- setData (10 pts) ---
test-setdata_changes_content: $(TEST_BIN)
	./$(TEST_BIN) "setdata_changes_content" --success

test-setdata_updates_length: $(TEST_BIN)
	./$(TEST_BIN) "setdata_updates_length" --success

# --- Integration (10 pts) ---
test-pass_by_value_triggers_copy: $(TEST_BIN)
	./$(TEST_BIN) "pass_by_value_triggers_copy" --success

test-chain_assignment: $(TEST_BIN)
	./$(TEST_BIN) "chain_assignment" --success

# =============================================================================
# GRADE: run every test individually, show points earned per test
# =============================================================================

grade: $(TEST_BIN)
	@echo ""
	@echo "================================================================"
	@echo "              GRADING REPORT  (100 points total)"
	@echo "================================================================"
	@TOTAL=0; \
	echo ""; \
	echo "--- CONSTRUCTOR (15 pts) ----------------------------------"; \
	if ./$(TEST_BIN) "basic_construction"    -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  basic_construction ............  5 / 5";  TOTAL=$$((TOTAL+5));  else echo "  [FAIL]  basic_construction ............  0 / 5";  fi; \
	if ./$(TEST_BIN) "constructor_counter"    -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  constructor_counter ...........  5 / 5";  TOTAL=$$((TOTAL+5));  else echo "  [FAIL]  constructor_counter ...........  0 / 5";  fi; \
	if ./$(TEST_BIN) "empty_string_construct" -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  empty_string_construct ........  5 / 5";  TOTAL=$$((TOTAL+5));  else echo "  [FAIL]  empty_string_construct ........  0 / 5";  fi; \
	echo ""; \
	echo "--- DESTRUCTOR (15 pts) -----------------------------------"; \
	if ./$(TEST_BIN) "destructor_called"      -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  destructor_called .............  5 / 5";  TOTAL=$$((TOTAL+5));  else echo "  [FAIL]  destructor_called .............  0 / 5";  fi; \
	if ./$(TEST_BIN) "destructor_counter"     -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  destructor_counter ............  5 / 5";  TOTAL=$$((TOTAL+5));  else echo "  [FAIL]  destructor_counter ............  0 / 5";  fi; \
	if ./$(TEST_BIN) "multiple_destructions"  -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  multiple_destructions .........  5 / 5";  TOTAL=$$((TOTAL+5));  else echo "  [FAIL]  multiple_destructions .........  0 / 5";  fi; \
	echo ""; \
	echo "--- COPY CONSTRUCTOR (25 pts) -----------------------------"; \
	if ./$(TEST_BIN) "copy_has_same_data"     -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  copy_has_same_data ............  7 / 7";  TOTAL=$$((TOTAL+7));  else echo "  [FAIL]  copy_has_same_data ............  0 / 7";  fi; \
	if ./$(TEST_BIN) "copy_is_deep"           -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  copy_is_deep ..................  8 / 8";  TOTAL=$$((TOTAL+8));  else echo "  [FAIL]  copy_is_deep ..................  0 / 8";  fi; \
	if ./$(TEST_BIN) "copy_counter"           -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  copy_counter ..................  5 / 5";  TOTAL=$$((TOTAL+5));  else echo "  [FAIL]  copy_counter ..................  0 / 5";  fi; \
	if ./$(TEST_BIN) "copy_empty_string"      -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  copy_empty_string .............  5 / 5";  TOTAL=$$((TOTAL+5));  else echo "  [FAIL]  copy_empty_string .............  0 / 5";  fi; \
	echo ""; \
	echo "--- ASSIGNMENT OPERATOR (25 pts) --------------------------"; \
	if ./$(TEST_BIN) "assignment_copies_data" -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  assignment_copies_data ........  7 / 7";  TOTAL=$$((TOTAL+7));  else echo "  [FAIL]  assignment_copies_data ........  0 / 7";  fi; \
	if ./$(TEST_BIN) "assignment_is_deep"     -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  assignment_is_deep ............  8 / 8";  TOTAL=$$((TOTAL+8));  else echo "  [FAIL]  assignment_is_deep ............  0 / 8";  fi; \
	if ./$(TEST_BIN) "assignment_counter"     -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  assignment_counter ............  5 / 5";  TOTAL=$$((TOTAL+5));  else echo "  [FAIL]  assignment_counter ............  0 / 5";  fi; \
	if ./$(TEST_BIN) "self_assignment_safe"   -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  self_assignment_safe ..........  5 / 5";  TOTAL=$$((TOTAL+5));  else echo "  [FAIL]  self_assignment_safe ..........  0 / 5";  fi; \
	echo ""; \
	echo "--- SETDATA (10 pts) --------------------------------------"; \
	if ./$(TEST_BIN) "setdata_changes_content" -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  setdata_changes_content .......  5 / 5";  TOTAL=$$((TOTAL+5));  else echo "  [FAIL]  setdata_changes_content .......  0 / 5";  fi; \
	if ./$(TEST_BIN) "setdata_updates_length"  -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  setdata_updates_length ........  5 / 5";  TOTAL=$$((TOTAL+5));  else echo "  [FAIL]  setdata_updates_length ........  0 / 5";  fi; \
	echo ""; \
	echo "--- INTEGRATION (10 pts) ----------------------------------"; \
	if ./$(TEST_BIN) "pass_by_value_triggers_copy" -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  pass_by_value_triggers_copy ...  5 / 5";  TOTAL=$$((TOTAL+5));  else echo "  [FAIL]  pass_by_value_triggers_copy ...  0 / 5";  fi; \
	if ./$(TEST_BIN) "chain_assignment"             -r compact 2>/dev/null | grep -q "passed"; then echo "  [PASS]  chain_assignment ..............  5 / 5";  TOTAL=$$((TOTAL+5));  else echo "  [FAIL]  chain_assignment ..............  0 / 5";  fi; \
	echo ""; \
	echo "================================================================"; \
	echo "  TOTAL SCORE:  $$TOTAL / 100"; \
	echo "================================================================"; \
	echo ""

# =============================================================================
# CLEAN
# =============================================================================

clean:
	rm -f $(TARGET) $(TEST_BIN)
