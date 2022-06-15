import 'package:flutter/material.dart';

enum AppTheme {
  light,
  dark
}

final appThemeData = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    extensions: const <ThemeExtension<dynamic>>[
      CustomColors.light
    ],
  ),

  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    extensions: const <ThemeExtension<dynamic>>[
      CustomColors.dark
    ],
  )
};

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color? onAppBar;

  const CustomColors({
    required this.onAppBar,
  });

  @override
  CustomColors copyWith({
    Color? onAppBar,
  }) {
    return CustomColors(
      onAppBar: onAppBar ?? this.onAppBar
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      onAppBar: Color.lerp(onAppBar, other.onAppBar, t),
    );
  }

  static const light = CustomColors(
    onAppBar: Colors.black,
  );

  static const dark = CustomColors(
    onAppBar: Colors.white,
  );
}