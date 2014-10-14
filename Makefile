PKGS=--pkg gtk+-3.0 --pkg libsoup-2.4
SOURCES=dom-test.vala custom-web-view.vala

# If you have webkit2gtk-4.0 installed, you should have the .vapi files installed, so use these
+#WEBKIT_VAPI=--pkg webkit2gtk-4.0
+# Otherwise, use the -3.0 versions included here
+WEBKIT_VAPI=--vapidir=. --pkg webkit2gtk-3.0

dom-test: $(SOURCES)
	valac $(WEBKIT_VAPI) $(PKGS) $^
