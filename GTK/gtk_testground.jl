using Gtk
win = GtkWindow("My First Gtk.jl Program", 400, 200);
b = GtkButton("Click Me");
push!(win,b);
function on_button_clicked(w)
  println("The button has been clicked")
end;
signal_connect(on_button_clicked, b, "clicked");
showall(win);

set_gtk_property!(win, :title, "New Titleeee")
visible(win, true)

###################################

win = GtkWindow("New title")
hbox = GtkBox(:h)
push!(win,hbox)
cancel = GtkButton("Cancel")
ok = GtkButton("OK")
push!(hbox,cancel)
push!(hbox,ok)
showall(win)

length(hbox)
get_gtk_property(hbox[1], :label, String)
set_gtk_property!(hbox,:expand,ok,true)
set_gtk_property!(hbox,:spacing,10)

destroy(hbox)
hbox = GtkButtonBox(:h)
push!(win, hbox)
push!(hbox, cancel)
push!(hbox, ok)
showall(win)

###################################
win = GtkWindow("A new window")
g = GtkGrid()
a = GtkEntry()  # a widget for entering text
set_gtk_property!(a, :text, "This is Gtk!")
b = GtkCheckButton("Check me!")
c = GtkScale(false, 0:10)     # a slider

# Now let's place these graphical elements into the Grid:
g[1,1] = a    # Cartesian coordinates, g[x,y]
g[2,1] = b
g[1:2,2] = c  # spans both columns
set_gtk_property!(g, :column_homogeneous, true)
set_gtk_property!(g, :column_spacing, 15)  # introduce a 15-pixel gap between columns
push!(win, g)
showall(win)
