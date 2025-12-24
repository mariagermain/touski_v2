import 'package:stacked/stacked_annotations.dart';
import 'package:touski/presentation/views/home/home_view.dart';
import 'package:touski/presentation/views/picture/take_picture_view.dart';
import 'package:touski/presentation/views/recipe/recipe_view.dart';

@StackedApp(routes: [
  MaterialRoute(page: HomeView), 
  MaterialRoute(page: TakePictureView),
  MaterialRoute(page: RecipeView),
])
class App{}