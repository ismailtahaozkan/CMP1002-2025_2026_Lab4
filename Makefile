CXX      = g++
CXXFLAGS = -Wall --std=c++17
TARGET   = MainProgram
TEST_BIN = test_runner

# Source files
MAIN_SRC  = MainProgram.cpp
TEST_SRC  = test.cpp
CATCH_SRC = catch_amalgamated.cpp

.PHONY: all test clean

# Build the main program
all: $(TARGET)

$(TARGET): $(MAIN_SRC)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(MAIN_SRC)

# Build and run tests
test: $(TEST_BIN)
	./$(TEST_BIN) --success

$(TEST_BIN): $(TEST_SRC) $(CATCH_SRC) $(MAIN_SRC)
	$(CXX) $(CXXFLAGS) -o $(TEST_BIN) $(TEST_SRC) $(CATCH_SRC)

clean:
	rm -f $(TARGET) $(TEST_BIN)
