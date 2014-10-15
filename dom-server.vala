[DBus (name = "org.example.DOMTest")]
public class DOMServer : Object {
    
    private int count = 0;
    private WebKit.WebPage page;
    
    public signal void div_clicked(string number);
    
    public void add_div(string color) {
        int x = Random.int_range(0, 300),
            y = Random.int_range(0, 300);
        count += 1;
        WebKit.DOM.Document document = page.get_dom_document();
        try {
            WebKit.DOM.Element el = document.create_element("div");
            el.append_child(document.create_text_node(@"$count"));
            el.set_attribute("style", @"background: $color; left: $x; top: $y;");
            el.set_attribute("id", @"$count");
            ((WebKit.DOM.EventTarget) el).add_event_listener("click", (Callback) on_div_clicked,
                false, this);
            document.body.insert_before(el, null);
        } catch (Error error) {
            warning("Oh noes: %s", error.message);
        }
    }
    
    [DBus (visible = false)]
    public void on_bus_aquired(DBusConnection connection) {
        try {
            connection.register_object("/org/example/domtest", this);
        } catch (IOError error) {
            warning("Could not register service: %s", error.message);
        }
    }
    
    [DBus (visible = false)]
    public void on_page_created(WebKit.WebExtension extension, WebKit.WebPage page) {
        this.page = page;
    }
    
    public static void on_div_clicked(WebKit.DOM.Element element, WebKit.DOM.Event event, DOMServer server) {
        server.div_clicked(element.get_attribute("id"));
    }
}

[DBus (name = "org.example.DOMTest")]
public errordomain DOMServerError {
    ERROR
}

[CCode (cname = "G_MODULE_EXPORT webkit_web_extension_initialize", instance_pos = -1)]
void webkit_web_extension_initialize(WebKit.WebExtension extension) {
    DOMServer server = new DOMServer();
    extension.page_created.connect(server.on_page_created);
    Bus.own_name(BusType.SESSION, "org.example.DOMTest", BusNameOwnerFlags.NONE,
        server.on_bus_aquired, null, () => { warning("Could not aquire name"); });
}
