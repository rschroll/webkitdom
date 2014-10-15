[DBus (name = "org.example.DOMTest")]
interface DOMMessenger : Object {
    public signal void div_clicked (string num);
    public abstract void add_div(string color) throws IOError;
}

public class CustomWebView : WebKit.WebView {
    
    public signal void div_clicked(string number);
    
    private const string HTML = """<html>
    <head><style>
    div {
        position: absolute;
        width: 98px;
        height: 98px;
        border: 1px solid black;
        font-size: 80px;
        text-align: center;
    }
    </style></head>
    <body></body></html>""";
    
    private DOMMessenger messenger = null;
    
    public CustomWebView() {
        Bus.watch_name(BusType.SESSION, "org.example.DOMTest", BusNameWatcherFlags.NONE,
            (connection, name, owner) => { on_extension_appeared(connection, name, owner); }, null);
        load_html(HTML, null);
    }
    
    public void add_div(string color) {
        if (messenger != null) {
            try {
                messenger.add_div(color);
            } catch (Error error) {
                warning("Error adding div: %s", error.message);
            }
        }
    }
    
    private void on_extension_appeared(DBusConnection connection, string name, string owner) {
        try {
            messenger = connection.get_proxy_sync("org.example.DOMTest", "/org/example/domtest",
                DBusProxyFlags.NONE, null);
            messenger.div_clicked.connect((num) => { div_clicked(num); });
        } catch (IOError error) {
            warning("Problem connecting to extension: %s", error.message);
        }
    }
}
