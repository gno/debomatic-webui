from gi.repository import Gtk
from debomatic_gui.gtk.headerbar import HeaderBar
from debomatic_gui.gtk.sidebar import Sidebar

class MyWindow(Gtk.Window):

    def __init__(self, view):
        Gtk.Window.__init__(self)
        self.view = view
        # header bar
        self.headerbar = HeaderBar()
        self.headerbar.set_title("Hello World")
        self.set_titlebar(self.headerbar)
        self.view.attach_observer(self.headerbar)
        self.set_size_request(400, 500)

        # sidebar
        sidebar = Sidebar(view)

        scroll = Gtk.ScrolledWindow()
        scroll.set_policy(Gtk.PolicyType.NEVER,
                          Gtk.PolicyType.AUTOMATIC)
        scroll.add(sidebar)

        self.add(scroll)

        self.connect('delete-event', self.on_delete)

        if not self.view.is_started:
            self.view.start()

    def on_delete(self, window, event):
        self.view.stop()
        Gtk.main_quit(window)

if __name__ == '__main__':
    from debomatic_gui.base.view import View

    view = View('localhost')
    win = MyWindow(view)
    win.show_all()
    Gtk.main()

