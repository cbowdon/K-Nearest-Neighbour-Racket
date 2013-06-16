SOURCES = src/main.rkt
OUTPUT = knn

all: $(SOURCES)
	racket $^

run: exe
	./$(OUTPUT)

exe: $(SOURCES)
	raco exe -o $(OUTPUT) $^
