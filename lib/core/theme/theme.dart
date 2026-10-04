import 'package:material_ui/material_ui.dart';
import 'package:google_fonts/google_fonts.dart';

ColorScheme _customColorScheme(Brightness brightness) {
  return ColorScheme.fromSeed(
    brightness: brightness,
    seedColor: Colors.deepOrange,
  );
}

TextTheme _customTextTheme(Brightness brightness) {
  final TextTheme baseTextTheme = ThemeData(
    brightness: brightness,
    colorScheme: _customColorScheme(brightness),
  ).textTheme;
  return GoogleFontsLite.getTextTheme('Google Sans Code', baseTextTheme);
}

ThemeData _customTheme(Brightness brightness) {
  return ThemeData(
    brightness: brightness,
    colorScheme: _customColorScheme(brightness),
    textTheme: _customTextTheme(brightness),

    iconButtonTheme: const IconButtonThemeData(
      style: ButtonStyle(
        // TODO: revisit this
        // foregroundColor: WidgetStatePropertyAll(
        //   _customColorScheme(brightness).onSurface,
        // ),
      ),
    ),

    menuTheme: const MenuThemeData(
      style: MenuStyle(padding: WidgetStatePropertyAll(EdgeInsets.all(10))),
    ),

    visualDensity: VisualDensity.compact,
  );
}

ThemeData lightThemeData = _customTheme(Brightness.light);
ThemeData darkThemeData = _customTheme(Brightness.dark);
