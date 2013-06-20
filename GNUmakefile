SOURCES = src/main.rkt
TESTS = src/test.rkt
OUTPUT = knn

all: $(SOURCES)
	racket $^

test: $(TESTS)
	racket $^

run: exe
	./$(OUTPUT)

exe: $(SOURCES)
	raco exe -o $(OUTPUT) $^
