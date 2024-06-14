

import 'package:flutter/material.dart';

const Color _customColor = Color.fromRGBO(105, 40, 179, 0);

const List<Color> _colorThemes = [
  _customColor,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
  Colors.blue,
];

class AppTheme {
  final int selectedColor;

  AppTheme({
    required this.selectedColor
  }) : assert(selectedColor >=0 && selectedColor < _colorThemes.length, 'Colors must be between 0 and ${_colorThemes.length}');

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[selectedColor],
      brightness: Brightness.light,
  
    );
  }

}