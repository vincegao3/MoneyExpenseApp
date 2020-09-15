import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum Category {
  financials,
  home,
  leisure,
  others,
}

extension ECategory on Category {
  static Category of(String value) {
    switch (value) {
      case 'Financials':
        return Category.financials;
      case 'Home':
        return Category.home;
      case 'Leisure':
        return Category.leisure;
      case 'Others':
        return Category.others;
      default:
        print(value);
        return null;
    }
  }

  String get icon => 'assets/category/ic_cat_${this.toString().replaceAll('Category.', '')}.svg';

  Widget iconWidget({
    Color color = Colors.white,
    double size = 24.0,
  }) =>
      SvgPicture.asset(
        icon,
        color: color,
        width: size,
        height: size,
      );

  Color get color {
    switch (this) {
      case Category.financials:
        return Color(0xFFFF899C);
      case Category.home:
        return Color(0xFF00C5A7);
      case Category.leisure:
        return Color(0xFF0D559D);
      case Category.others:
        return Color(0xFF60322D);
    }
    return Colors.transparent;
  }

  String get name {
      return this.toString().replaceAll('Category.', '');
  }

  static List<Category> get values => [
        Category.financials,
        Category.home,
        Category.leisure,
        Category.others,
      ];

  static List<Color> get colors => values.map((e) => e.color).toList();
}
