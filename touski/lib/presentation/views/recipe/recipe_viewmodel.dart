import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:touski/domain/usecases/get_recipe_usecase.dart';
import 'package:touski/generated/locale_keys.g.dart';
import 'package:touski/presentation/app/app_setup.dart';
import 'package:touski/presentation/helper/map_exception_to_message.dart';

class RecipeViewModel extends BaseViewModel{
  final navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final GetRecipeUsecase recipeUsecase = locator<GetRecipeUsecase>();
  final List<String> foods;
  late String _recipe;

  RecipeViewModel({required this.foods});
  String get recipe => _recipe;

  Future<void> getRecipe() async {
    setBusy(true);
    try{
      _recipe = await recipeUsecase.execute(foods);
    } catch (e) {
      _recipe = "";
      _dialogService.showDialog(title: LocaleKeys.message_failure_announcement.tr(), description: mapExceptionToMessage(e as Exception));
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }
}