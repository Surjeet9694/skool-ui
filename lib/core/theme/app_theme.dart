import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralised Material 3 theme system for Skool.
/// Supports light and dark modes with a consistent design language.
final class AppTheme {
  AppTheme._();

  // ─── Color Palette ─────────────────────────────────────────────────────────
  static const Color _primarySeed = Color(0xFF4F46E5); // Indigo
  static const Color _secondaryColor = Color(0xFF06B6D4); // Cyan
  static const Color _errorColor = Color(0xFFEF4444);
  static const Color _successColor = Color(0xFF10B981);
  static const Color _warningColor = Color(0xFFF59E0B);

  // Dark mode specific
  static const Color _darkSurface = Color(0xFF0F172A); // Slate 900
  static const Color _darkCard = Color(0xFF1E293B); // Slate 800
  static const Color _darkBorder = Color(0xFF334155); // Slate 700

  // ─── Typography ────────────────────────────────────────────────────────────
  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    return GoogleFonts.outfitTextTheme(
      TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.25,
          color: colorScheme.onSurface,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurfaceVariant,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
          color: colorScheme.onSurface,
        ),
      ),
    );
  }

  // ─── Light Theme ───────────────────────────────────────────────────────────
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _primarySeed,
      brightness: Brightness.light,
      secondary: _secondaryColor,
      error: _errorColor,
    );

    return _buildTheme(colorScheme);
  }

  // ─── Dark Theme ────────────────────────────────────────────────────────────
  static ThemeData get dark {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _primarySeed,
      brightness: Brightness.dark,
      secondary: _secondaryColor,
      error: _errorColor,
      surface: _darkSurface,
    ).copyWith(
      surface: _darkSurface,
      surfaceContainerHighest: _darkCard,
      outline: _darkBorder,
    );

    return _buildTheme(colorScheme);
  }

  static ThemeData _buildTheme(ColorScheme colorScheme) {
    final isDark = colorScheme.brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: _buildTextTheme(colorScheme),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: isDark ? _darkSurface : colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
        ),
      ),

      // Cards
      cardTheme: CardTheme(
        color: isDark ? _darkCard : colorScheme.surface,
        elevation: isDark ? 0 : 1,
        shadowColor: colorScheme.shadow.withOpacity(0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isDark ? _darkBorder : colorScheme.outlineVariant,
            width: 0.5,
          ),
        ),
      ),

      // Input Fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? _darkCard : colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? _darkBorder : colorScheme.outlineVariant,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          minimumSize: const Size(double.infinity, 52),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Navigation Bar
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: isDark ? _darkCard : colorScheme.surface,
        indicatorColor: colorScheme.primaryContainer,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return GoogleFonts.outfit(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            );
          }
          return GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: colorScheme.onSurfaceVariant,
          );
        }),
      ),

      // Bottom Sheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: isDark ? _darkCard : colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),

      // Divider
      dividerTheme: DividerThemeData(
        color: isDark ? _darkBorder : colorScheme.outlineVariant,
        thickness: 0.5,
      ),

      // Extension colors
      extensions: [
        SkoolColors(
          success: _successColor,
          warning: _warningColor,
          cardBackground: isDark ? _darkCard : colorScheme.surface,
          border: isDark ? _darkBorder : colorScheme.outlineVariant,
        ),
      ],
    );
  }
}

/// Custom theme extension for domain-specific colors.
@immutable
class SkoolColors extends ThemeExtension<SkoolColors> {
  const SkoolColors({
    required this.success,
    required this.warning,
    required this.cardBackground,
    required this.border,
  });

  final Color success;
  final Color warning;
  final Color cardBackground;
  final Color border;

  @override
  SkoolColors copyWith({
    Color? success,
    Color? warning,
    Color? cardBackground,
    Color? border,
  }) {
    return SkoolColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      cardBackground: cardBackground ?? this.cardBackground,
      border: border ?? this.border,
    );
  }

  @override
  SkoolColors lerp(SkoolColors? other, double t) {
    if (other is! SkoolColors) return this;
    return SkoolColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      border: Color.lerp(border, other.border, t)!,
    );
  }
}
