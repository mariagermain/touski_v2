import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:touski/generated/locale_keys.g.dart';
import 'package:touski/presentation/views/recipe/recipe_viewmodel.dart';

class RecipeView extends StatelessWidget {
  const RecipeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecipeViewModel>.reactive(
      viewModelBuilder: () => RecipeViewModel(),
      disposeViewModel: false,
      builder: (context, viewModel, child) {
      return Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.recipe_title.tr())),
          body: Scaffold()
        );
      }
    );    
  }
}