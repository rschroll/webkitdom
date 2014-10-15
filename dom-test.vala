class DOMTestApp : Gtk.Application {
    
    public override void activate() {
        WebKit.WebContext.get_default().set_web_extensions_directory("./");
        
        var window = new Gtk.ApplicationWindow(this);
        window.set_default_size(400, 450);
        
        var vbox = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
        window.add(vbox);
        
        var hbox = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
        vbox.pack_start(hbox, false, false);
        
        var button = new Gtk.Button.with_label("Add div");
        hbox.pack_start(button, false, false);
        
        var rgba = Gdk.RGBA();
        rgba.parse("#ddd");
        var color = new Gtk.ColorButton.with_rgba(rgba);
        hbox.pack_start(color, false, false);
        
        var label = new Gtk.Label("");
        hbox.pack_start(label, true, true);
        
        var webview = new CustomWebView();
        vbox.pack_start(webview, true, true);
        
        webview.div_clicked.connect((num) => { label.set_text(@"Clicked div $num"); });
        button.clicked.connect(() => { webview.add_div(color.rgba.to_string()); });
        
        window.show_all();
    }
    
    static int main (string[] args) {
        return new DOMTestApp().run(args);
    }
}
