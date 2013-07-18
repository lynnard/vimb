include config.mk

-include $(DEPS)

all: $(TARGET) man

options:
	@echo "$(PROJECT) build options:"
	@echo "LIBS      = $(LIBS)"
	@echo "CC        = $(CC)"
	@echo "CFLAGS    = $(CFLAGS)"
	@echo "CPPFLAGS  = $(CPPFLAGS)"
	@echo "LDFLAGS   = $(LDFLAGS)"

src/hints.o: src/hints.js.h
src/hints.js.h: src/hints.js
	@echo "minify $<"
	@cat $< | src/js2h.sh > $@

$(TARGET): $(OBJ)
	@echo "$(CC) $@"
	@$(CC) $(OBJ) -o $(TARGET) $(LDFLAGS)

src/config.h: src/config.def.h
	@echo create $@ from src/config.def.h
	@cp src/config.def.h $@

%.o: %.c %.h src/config.h
	@echo "${CC} $<"
	@$(CC) -c -o $@ $< $(CPPFLAGS) $(CFLAGS)

debug: $(DTARGET)

$(DTARGET): $(DOBJ)
	@echo "$(CC) $@"
	@$(CC) $(DFLAGS) $(DOBJ) -o $(DTARGET) $(LDFLAGS)

%.do: %.c %.h
	@echo "${CC} $<"
	@$(CC) -c -o $@ $< $(CPPFLAGS) $(DFLAGS)

man:
	@$(MAKE) $(MFLAGS) -C doc man

install: $(TARGET)
	install -d $(DESTDIR)$(BINDIR)
	install -m 755 $(TARGET) $(DESTDIR)$(BINDIR)/$(TARGET)
	@$(MAKE) $(MFLAGS) -C doc install

uninstall:
	$(RM) $(DESTDIR)$(BINDIR)/$(TARGET)
	@$(MAKE) $(MFLAGS) -C doc uninstall

clean:
	@$(MAKE) $(MFLAGS) -C doc clean
	$(RM) src/*.o src/*.do src/hints.js.h $(TARGET) $(DTARGET)

dist: distclean
	@echo "Creating tarball."
	@git archive --format tar -o $(DIST_FILE) HEAD

distclean:
	$(RM) $(DIST_FILE)

.PHONY: clean debug all install uninstall options dist
