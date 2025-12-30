import 'package:image/image.dart';
import 'package:touski/domain/entities/food_classes.dart';

class Detection {
  FoodClass foodClass;
  double score;
  Box box;

  Detection({required this.foodClass, required this.score, required this.box});

  Color get color => foodClass.color;
}

class Box {
  final double x;
  final double y; 
  final double w; 
  final double h; 

  const Box({
    required this.x,
    required this.y,
    required this.w,
    required this.h,
  });

  double get right => x + w;
  double get bottom => y + h;

  double get area => w * h;

}