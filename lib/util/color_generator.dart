import 'package:authenticator/util/card_colors.dart';

class ColorGenerator {
  static const List<CardColor> _cardColors = [
    CardColors.red,
    CardColors.pink,
    CardColors.purple,
    CardColors.deepPurple,
    CardColors.indigo,
    CardColors.blue,
    CardColors.lightBlue,
    CardColors.cyan,
    CardColors.teal,
    CardColors.green,
    CardColors.lightGreen,
    CardColors.lime,
    CardColors.yellow,
    CardColors.amber,
    CardColors.orange,
    CardColors.deepOrange,
    CardColors.brown,
    CardColors.grey,
    CardColors.blueGrey
  ];

  static CardColor getColor(Object key) {
    return _cardColors[(key.hashCode % _cardColors.length).abs()];
  }
}