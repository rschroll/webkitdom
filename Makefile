PKGS=--pkg gtk+-3.0 --pkg libsoup-2.4
SOURCES=dom-test.vala custom-web-view.vala
WEBKIT_VAPI=--vapidir=. --pkg webkitgtk-3.0

dom-test: $(SOURCES)
	valac $(WEBKIT_VAPI) $(PKGS) $^
