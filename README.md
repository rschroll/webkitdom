DOM Manipulation in WebKit2GTK
==============================
[WebKit2GTK][1] runs the web process separately from the UI process.
This increases stability and robustness but prevents [direct access to
the DOM][2] from the UI process.  Here, we present two methods to
interact with the DOM in WebKit2GTK.

[1]: http://webkitgtk.org/
[2]: http://blogs.igalia.com/carlosgc/2013/09/10/webkit2gtk-web-process-extensions/

Branches
--------
There are three branches in this repository:

* **[master][3]** shows a test program using the older WebKitGTK
bindings, which allow for direct access to the DOM.  The program
presents a WebView and a button, which inserts numbered divs, of the
selected color, into the DOM.  Clicking on these divs triggers a message
in a Label.

* **[javascript][4]** shows the same behavior, but with the WebKit2GTK
bindings.  The DOM is manipulated by injected Javascript, and messages
are passed back to the UI through the title of the WebView.  This
solution is easier but more limited than using a web extension.

* **[extension][5]** uses the new WebExtension API to load a .so file
into the web process to do the DOM manipulation.  This communicates over
with the UI process over DBus.  **Please note that attaching to DOM
events is not currently working.**

[3]: https://github.com/rschroll/webkitdom/tree/master
[4]: https://github.com/rschroll/webkitdom/tree/javascript
[5]: https://github.com/rschroll/webkitdom/tree/extension

VAPI Files
----------
Until recently, VAPI files were not shipped with WebKit, so we have
included them in the repository.  If you system does have the VAPI files
installed, you may adjust the Makefile to use them.

About
-----
These examples were developed by Michael Catanzaro and Robert Schroll at
the [2014 GNOME Summit][6].  The authors release their work into the
public domain.  Do note that the VAPI files are derived from the WebKit
source and inherit their copyright and licenses.

[6]: https://wiki.gnome.org/Events/Summit/2014
