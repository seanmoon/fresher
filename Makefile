BINS = bin/fsevent_watch 

all:	$(BINS)

CFLAGS = -Wall -O3

bin/fsevent_watch: LDFLAGS+=-lc -framework CoreServices
bin/fsevent_watch: objs/fsevent_watch.o

bin objs:
	mkdir $@

bin/%: | bin
	$(CC) -o $@ $^ $(CFLAGS) $(LDFLAGS)

objs/%.o: %.c | objs
	$(CC) -c -o $@ $< $(CFLAGS)

clean:
	-rm $(BINS)
	-rm objs/*
	-rm -r bin objs

