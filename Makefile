PKGS=--pkg gtk+-3.0 --pkg libsoup-2.4
EXEC=dom-test
SOURCES=dom-test.vala custom-web-view.vala
LIB_BASE=dom-server
LIB_SOURCES=$(LIB_BASE).vala
LIBRARY=$(LIB_BASE).so

# If you have webkit2gtk-4.0 installed, you should have the .vapi files installed, so use these
#WEBKIT_VAPI=--pkg webkit2gtk-4.0
#WEBKIT_EXT_VAPI=--pkg webkit2gtk-web-extension-4.0
# Otherwise, use the -3.0 versions included here
WEBKIT_VAPI=--vapidir=. --pkg webkit2gtk-3.0
WEBKIT_EXT_VAPI=--vapidir=. --pkg webkit2gtk-web-extension-3.0 -X -I/usr/include/webkitgtk-3.0

all: $(EXEC) $(LIBRARY)

$(EXEC): $(SOURCES)
	valac $(WEBKIT_VAPI) $(PKGS) $^

$(LIBRARY): $(LIB_SOURCES)
	valac $(WEBKIT_EXT_VAPI) $(PKGS) --library=$(LIB_BASE) -X -fPIC -X -shared -o $@ $^

clean:
	rm $(EXEC) $(LIBRARY)
