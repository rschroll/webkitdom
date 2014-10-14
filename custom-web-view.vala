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
    private const string JAVASCRIPT = """
        var el = document.createElement("div");
        el.appendChild(document.createTextNode("%i"));
        el.setAttribute("style", "background: %s; left: %i; top: %i;");
        el.id = "%i";
        el.onclick = function () { document.title = "div-clicked %i"; };
        document.body.insertBefore(el);""";
    
    private int count = 0;
    
    public CustomWebView() {
        load_html(HTML, null);
        notify["title"].connect(on_title_changed);
    }
    
    public void add_div(string color) {
        int x = Random.int_range(0, 300),
            y = Random.int_range(0, 300);
        count += 1;
        run_javascript.begin(JAVASCRIPT.printf(count, color, x, y, count, count), null);
    }
    
    private void on_title_changed(ParamSpec p) {
        string[] args = title.split(" ", 2);
        if (args[0] == "div-clicked")
            div_clicked(args[1]);
    }
}
