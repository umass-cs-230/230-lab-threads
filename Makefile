CC=gcc
CFLAGS=-Wall -Wextra -g -pthread
CPPFLAGS=$(CFLAGS) -std=c++11

ODIR=obj
SDIR=src

all: challenge submission

$(ODIR):
	mkdir -p $(ODIR)

$(ODIR)/main.o: $(SDIR)/main.c $(ODIR)
	$(CC) $(CFLAGS) -c -o $@ $<

$(ODIR)/challenge.o: $(SDIR)/challenge.c $(ODIR)
	$(CC) $(CFLAGS) -c -o $@ $<

challenge: $(ODIR)/main.o $(ODIR)/challenge.o
	$(CC) $(CFLAGS) -o $@ $^

submission: $(SDIR)/main.c $(SDIR)/challenge.c $(SDIR)/challenge.h
	zip -r submission.zip $(SDIR)

clean:
	rm -f challenge
	rm -f submission.zip
	rm -rf $(ODIR)
