import 'package:material_ui/material_ui.dart';

abstract final class AppColors {
  static const background = Color(0xFF1C0B1C);
  static const bar = Color(0xFF12060F);
  static const surface = Color(0xFF35162C);
  static const elevated = Color(0xFF3A1A3C);
  static const pink = Color(0xFFFF8CC6);
  static const muted = Color(0xFFA4989C);
  static const text = Color(0xFFEDECEC);
  static const magenta = Color(0xFFE0449E);
  static const violet = Color(0xFF8A4FD8);
}

ThemeData buildTheme() {
  const scheme = ColorScheme.dark(
    primary: AppColors.pink,
    onPrimary: Color(0xFF330512),
    secondary: Color(0xFFE4B4C1),
    surface: AppColors.background,
    onSurface: AppColors.text,
    onSurfaceVariant: AppColors.muted,
    outline: Color(0xFFBA5376),
    outlineVariant: Color(0xFF542132),
    error: Color(0xFFF17892),
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    fontFamily: 'Outfit',
    scaffoldBackgroundColor: AppColors.background,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
      headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16, height: 1.5),
      bodyMedium: TextStyle(fontSize: 14, height: 1.4),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    ).apply(bodyColor: AppColors.text, displayColor: AppColors.text),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface.withValues(alpha: .65),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: const BorderSide(color: Color(0xFF853953)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(0, 52),
        textStyle: const TextStyle(
          fontFamily: 'Outfit',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
  );
}
