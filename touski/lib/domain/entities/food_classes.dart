import 'package:easy_localization/easy_localization.dart';
import 'package:image/image.dart';
import 'package:touski/generated/locale_keys.g.dart';

class FoodClass {
  final String name;
  final Color color;

  const FoodClass({
    required this.name,
    required this.color,
  });
}

final List<FoodClass> foodClasses = [
  FoodClass(name: LocaleKeys.foods_apple.tr(), color: ColorRgb8(183, 28, 28)),
  FoodClass(name: LocaleKeys.foods_banana.tr(), color: ColorRgb8(255, 235, 59)),
  FoodClass(name: LocaleKeys.foods_bellpepper.tr(), color: ColorRgb8(46, 125, 50)),
  FoodClass(name: LocaleKeys.foods_carrot.tr(), color: ColorRgb8(245, 124, 0)),
  FoodClass(name: LocaleKeys.foods_corn.tr(), color: ColorRgb8(255, 214, 0)),
  FoodClass(name: LocaleKeys.foods_cucumber.tr(), color: ColorRgb8(0, 121, 107)),
  FoodClass(name: LocaleKeys.foods_eggplant.tr(), color: ColorRgb8(74, 20, 140)),
  FoodClass(name: LocaleKeys.foods_grapes.tr(), color: ColorRgb8(81, 45, 168)),
  FoodClass(name: LocaleKeys.foods_kiwi.tr(), color: ColorRgb8(124, 179, 66)),
  FoodClass(name: LocaleKeys.foods_lemon.tr(), color: ColorRgb8(255, 241, 118)),
  FoodClass(name: LocaleKeys.foods_orange.tr(), color: ColorRgb8(239, 108, 0)),
  FoodClass(name: LocaleKeys.foods_pear.tr(), color: ColorRgb8(156, 204, 101)),
  FoodClass(name: LocaleKeys.foods_pineapple.tr(), color: ColorRgb8(255, 238, 88)),
  FoodClass(name: LocaleKeys.foods_potato.tr(), color: ColorRgb8(109, 76, 65)),
  FoodClass(name: LocaleKeys.foods_tomato.tr(), color: ColorRgb8(198, 40, 40))
];


