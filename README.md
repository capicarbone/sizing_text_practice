## Goal

Implement in flutter a way to show texts with different lengths into a size limited space. The text
should be shown in a default font size if possible.

## References

- https://github.com/leisim/auto_size_text/blob/master/lib/src/auto_size_text.dart
- https://stackoverflow.com/questions/63659812/how-can-i-know-when-a-google-font-have-been-loaded-completely-in-flutter-for-web

## Notes

There is a caveat when google_fonts library it's used (and maybe any font different from the default one). As a font load
is asynchronous, the initial font size calculation it's made using the default font, so when the font is finally loaded, the text it's not going to
be correctly adjusted. Currently, there is not a way to be notified when a font has been loaded, I though that maybe a setState() call happens on
a font load, but a Text widget is stateless, so the widget update seems to happens on another level . The current solution (in this case)
seems to be to put an arbitrary wait time and then calculate the font size taking account the loaded font. It's desirable to include
the fonts as assets and thus load them from the filesystem.


## Demo

![Demo](/docs/demo.gif)


