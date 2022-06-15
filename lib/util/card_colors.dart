import 'package:flutter/material.dart';

enum ColorFor {
  cardBackground,
  cardDarkBackground,
  iconBackground,
  timerFill
}

class CardColor extends ColorSwatch<ColorFor> {
  const CardColor(int primary, Map<ColorFor, Color> swatch) : super(primary, swatch);

  Color get cardBackground => this[ColorFor.cardBackground]!;
  Color get cardDarkBackground => this[ColorFor.cardDarkBackground]!;
  Color get iconBackground => this[ColorFor.iconBackground]!;
  Color get timerFill => this[ColorFor.timerFill]!;
}

class CardColors {
  static const int _red = 0xFFffcdd2;
  static const CardColor red = CardColor(
    _red,
    <ColorFor, Color> {
      ColorFor.cardBackground: Color(_red),
      ColorFor.cardDarkBackground: Color(0xFFb71c1c),
      ColorFor.iconBackground: Color(0xFFef5350),
      ColorFor.timerFill: Color(0xFFd32f2f)
    }
  );

  static const int _pink = 0xFFf8bbd0;
  static const CardColor pink = CardColor(
    _pink,
    <ColorFor, Color> {
      ColorFor.cardBackground: Color(_pink),
      ColorFor.cardDarkBackground: Color(0xFF880e4f),
      ColorFor.iconBackground: Color(0xFFec407a),
      ColorFor.timerFill: Color(0xFFc2185b)
    }
  );

  static const int _purple = 0xFFe1bee7;
  static const CardColor purple = CardColor(
    _purple,
    <ColorFor, Color> {
      ColorFor.cardBackground: Color(_purple),
      ColorFor.cardDarkBackground: Color(0xFF4a148c),
      ColorFor.iconBackground: Color(0xFFab47bc),
      ColorFor.timerFill: Color(0xFF7b1fa2)
    }
  );

  static const int _deepPurple = 0xFFd1c4e9;
  static const CardColor deepPurple = CardColor(
      _deepPurple,
      <ColorFor, Color> {
        ColorFor.cardBackground: Color(_deepPurple),
        ColorFor.cardDarkBackground: Color(0xFF311b92),
        ColorFor.iconBackground: Color(0xFF7e57c2),
        ColorFor.timerFill: Color(0xFF512da8)
      }
  );

  static const int _indigo = 0xFFc5cae9;
  static const CardColor indigo = CardColor(
      _indigo,
      <ColorFor, Color> {
        ColorFor.cardBackground: Color(_indigo),
        ColorFor.cardDarkBackground: Color(0xFF1a237e),
        ColorFor.iconBackground: Color(0xFF5c6bc0),
        ColorFor.timerFill: Color(0xFF303f9f)
      }
  );

  static const int _blue = 0xFFbbdefb;
  static const CardColor blue = CardColor(
      _blue,
      <ColorFor, Color> {
        ColorFor.cardBackground: Color(_blue),
        ColorFor.cardDarkBackground: Color(0xFF0d47a1),
        ColorFor.iconBackground: Color(0xFF42a5f5),
        ColorFor.timerFill: Color(0xFF1976d2)
      }
  );

  static const int _lightBlue = 0xFFb3e5fc;
  static const CardColor lightBlue = CardColor(
      _lightBlue,
      <ColorFor, Color> {
        ColorFor.cardBackground: Color(_lightBlue),
        ColorFor.cardDarkBackground: Color(0xFF01579b),
        ColorFor.iconBackground: Color(0xFF29b6f6),
        ColorFor.timerFill: Color(0xFF0288d1)
      }
  );

  static const int _cyan = 0xFFb2ebf2;
  static const CardColor cyan = CardColor(
      _cyan,
      <ColorFor, Color> {
        ColorFor.cardBackground: Color(_cyan),
        ColorFor.cardDarkBackground: Color(0xFF006064),
        ColorFor.iconBackground: Color(0xFF26c6da),
        ColorFor.timerFill: Color(0xFF0097a7)
      }
  );

  static const int _teal = 0xFFb2dfdb;
  static const CardColor teal = CardColor(
      _teal,
      <ColorFor, Color> {
        ColorFor.cardBackground: Color(_teal),
        ColorFor.cardDarkBackground: Color(0xFF004d40),
        ColorFor.iconBackground: Color(0xFF26a69a),
        ColorFor.timerFill: Color(0xFF00796b)
      }
  );

  static const int _green = 0xFFc8e6c9;
  static const CardColor green = CardColor(
      _green,
      <ColorFor, Color> {
        ColorFor.cardBackground: Color(_green),
        ColorFor.cardDarkBackground: Color(0xFF1b5e20),
        ColorFor.iconBackground: Color(0xFF66bb6a),
        ColorFor.timerFill: Color(0xFF388e3c)
      }
  );

  static const int _lightGreen = 0xFFdcedc8;
  static const CardColor lightGreen = CardColor(
      _lightGreen,
      <ColorFor, Color> {
        ColorFor.cardBackground: Color(_lightGreen),
        ColorFor.cardDarkBackground: Color(0xFF33691e),
        ColorFor.iconBackground: Color(0xFF9ccc65),
        ColorFor.timerFill: Color(0xFF689f38)
      }
  );

  static const int _lime = 0xFFf0f4c3;
  static const CardColor lime = CardColor(
      _lime,
      <ColorFor, Color> {
        ColorFor.cardBackground: Color(_lime),
        ColorFor.cardDarkBackground: Color(0xFF827717),
        ColorFor.iconBackground: Color(0xFFd4e157),
        ColorFor.timerFill: Color(0xFFafb42b)
      }
  );

  static const int _yellow = 0xFFfff9c4;
  static const CardColor yellow = CardColor(
      _yellow,
      <ColorFor, Color> {
  ColorFor.cardBackground: Color(_yellow),
        ColorFor.cardDarkBackground: Color(0xFFf57f17),
  ColorFor.iconBackground: Color(0xFFffee58),
  ColorFor.timerFill: Color(0xFFfbc02d)
  }
  );

  static const int _amber = 0xFFffecb3;
  static const CardColor amber = CardColor(
      _amber,
      <ColorFor, Color> {
        ColorFor.cardBackground: Color(_amber),
        ColorFor.cardDarkBackground: Color(0xFFff6f00),
        ColorFor.iconBackground: Color(0xFFffca28),
        ColorFor.timerFill: Color(0xFFffa000)
      }
  );

  static const int _orange = 0xFFffe0b2;
  static const CardColor orange = CardColor(
      _orange,
      <ColorFor, Color> {
        ColorFor.cardBackground: Color(_orange),
        ColorFor.cardDarkBackground: Color(0xFFe65100),
        ColorFor.iconBackground: Color(0xFFffa726),
        ColorFor.timerFill: Color(0xFFf57c00)
      }
  );

  static const int _deepOrange = 0xFFffccbc;
  static const CardColor deepOrange = CardColor(
      _deepOrange,
      <ColorFor, Color> {
        ColorFor.cardBackground: Color(_deepOrange),
        ColorFor.cardDarkBackground: Color(0xFFbf360c),
        ColorFor.iconBackground: Color(0xFFff7043),
        ColorFor.timerFill: Color(0xFFe64a19)
      }
  );

  static const int _brown = 0xFFd7ccc8;
  static const CardColor brown = CardColor(
      _brown,
      <ColorFor, Color> {
        ColorFor.cardBackground: Color(_brown),
        ColorFor.cardDarkBackground: Color(0xFF3e2723),
        ColorFor.iconBackground: Color(0xFF8d6e63),
        ColorFor.timerFill: Color(0xFF5d4037)
      }
  );

  static const int _grey = 0xFFf5f5f5;
  static const CardColor grey = CardColor(
      _grey,
      <ColorFor, Color> {
        ColorFor.cardBackground: Color(_grey),
        ColorFor.cardDarkBackground: Color(0xFF212121),
        ColorFor.iconBackground: Color(0xFFbdbdbd),
        ColorFor.timerFill: Color(0xFF616161)
      }
  );

  static const int _blueGrey = 0xFFcfd8dc;
  static const CardColor blueGrey = CardColor(
      _blueGrey,
      <ColorFor, Color> {
        ColorFor.cardBackground: Color(_blueGrey),
        ColorFor.cardDarkBackground: Color(0xFF263238),
        ColorFor.iconBackground: Color(0xFF78909c),
        ColorFor.timerFill: Color(0xFF455a64)
      }
  );
}