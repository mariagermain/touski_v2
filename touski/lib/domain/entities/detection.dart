import 'package:image/image.dart';
import 'package:touski/domain/entities/food_classes.dart';

class Detection {
  FoodClass foodClass;
  double score;
  List<double> box;

  Detection(this.foodClass, this.score, this.box);

  Color get color => foodClass.color;
}