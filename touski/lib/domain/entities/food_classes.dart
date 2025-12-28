import 'package:image/image.dart';

class FoodClass {
  final String name;
  final Color color;

  const FoodClass({
    required this.name,
    required this.color,
  });
}

final List<FoodClass> foodClasses = [
  FoodClass(name: 'apple', color: ColorRgb8(183, 28, 28)),
  FoodClass(name: 'banana', color: ColorRgb8(255, 235, 59)),
  FoodClass(name: 'bellpepper', color: ColorRgb8(46, 125, 50)),
  FoodClass(name: 'carrot', color: ColorRgb8(245, 124, 0)),
  FoodClass(name: 'corn', color: ColorRgb8(255, 214, 0)),
  FoodClass(name: 'cucumber', color: ColorRgb8(0, 121, 107)),
  FoodClass(name: 'eggplant', color: ColorRgb8(74, 20, 140)),
  FoodClass(name: 'grapes', color: ColorRgb8(81, 45, 168)),
  FoodClass(name: 'kiwi', color: ColorRgb8(124, 179, 66)),
  FoodClass(name: 'lemon', color: ColorRgb8(255, 241, 118)),
  FoodClass(name: 'orange', color: ColorRgb8(239, 108, 0)),
  FoodClass(name: 'pear', color: ColorRgb8(156, 204, 101)),
  FoodClass(name: 'pineapple', color: ColorRgb8(255, 238, 88)),
  FoodClass(name: 'potato', color: ColorRgb8(109, 76, 65)),
  FoodClass(name: 'tomato', color: ColorRgb8(198, 40, 40))
];


