import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:touski/generated/locale_keys.g.dart';
import 'package:touski/presentation/views/recipe/recipe_viewmodel.dart';

class RecipeView extends StatelessWidget {
  final List<String> detectedFoods;

  const RecipeView({super.key, required this.detectedFoods});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecipeViewModel>.reactive(
      viewModelBuilder: () => RecipeViewModel(foods: detectedFoods),
      onViewModelReady: (viewModel) => viewModel.getRecipe(),
      disposeViewModel: false,
      builder: (context, viewModel, child) {
      return Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.recipe_title.tr())),
          body: Center(
            child: viewModel.isBusy 
            ? const CircularProgressIndicator() 
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 60),
                child: Text(
                  viewModel.recipe,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          )
        );
      }
    );    
  }
}