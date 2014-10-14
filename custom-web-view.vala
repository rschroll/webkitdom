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
    
    private int count = 0;
    
    public CustomWebView() {
        load_string(HTML, "text/html", "UTF8", "");
    }
    
    public void add_div(string color) {
        int x = Random.int_range(0, 300),
            y = Random.int_range(0, 300);
        count += 1;
        WebKit.DOM.Document doc = get_dom_document();
        try {
            WebKit.DOM.Element el = doc.create_element("div");
            el.append_child(doc.create_text_node(@"$count"));
            el.set_attribute("style", @"background: $color; left: $x; top: $y;");
            el.set_attribute("id", @"$count");
            ((WebKit.DOM.EventTarget) el).add_event_listener("click", (Callback) on_div_clicked,
                false, this);
            doc.body.insert_before(el, null);
        } catch (Error error) {
            warning("Oh noes: %s", error.message);
        }
    }
    
    private static void on_div_clicked(WebKit.DOM.Element element, WebKit.DOM.Event event,
        CustomWebView view) {
        view.div_clicked(element.get_attribute("id"));
    }
}
