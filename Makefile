CC=gcc
CFLAGS=-Wall -Wextra -g -pthread
CPPFLAGS=$(CFLAGS) -std=c++11
GTESTFLAGS=-lstdc++ -lgtest_main -lgtest -lpthread

ODIR=obj
SDIR=src
TDIR=test

all: challenge challenge_tests submission

$(ODIR):
	mkdir -p $(ODIR)

$(ODIR)/main.o: $(SDIR)/main.c $(ODIR)
	$(CC) $(CFLAGS) -c -o $@ $<

$(ODIR)/challenge.o: $(SDIR)/challenge.c $(ODIR)
	$(CC) $(CFLAGS) -c -o $@ $<

challenge: $(ODIR)/main.o $(ODIR)/challenge.o
	$(CC) $(CFLAGS) -o $@ $^

$(ODIR)/test.o: $(TDIR)/test.cpp $(ODIR)
	$(CC) $(CPPFLAGS) -c -o $@ $<

challenge_tests: $(ODIR)/test.o $(ODIR)/challenge.o
	$(CC) $(CPPFLAGS) -o $@ $^ $(GTESTFLAGS)

submission: $(SDIR)/main.c $(SDIR)/challenge.c $(SDIR)/challenge.h
	zip -r submission.zip $(SDIR)

clean:
	rm -f challenge
	rm -f challenge_tests
	rm -f submission.zip
	rm -rf $(ODIR)