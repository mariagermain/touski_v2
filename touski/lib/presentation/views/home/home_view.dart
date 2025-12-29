import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:touski/presentation/views/home/home_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:touski/generated/locale_keys.g.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static final supportedFoods = [
    '🍎 ${LocaleKeys.foods_apple.tr()}',
    '🍌 ${LocaleKeys.foods_banana.tr()}',
    '🫑 ${LocaleKeys.foods_bellpepper.tr()}',
    '🥕 ${LocaleKeys.foods_carrot.tr()}',
    '🌽 ${LocaleKeys.foods_corn.tr()}',
    '🥒 ${LocaleKeys.foods_cucumber.tr()}',
    '🍆 ${LocaleKeys.foods_eggplant.tr()}',
    '🍇 ${LocaleKeys.foods_grapes.tr()}',
    '🥝 ${LocaleKeys.foods_kiwi.tr()}',
    '🍋 ${LocaleKeys.foods_lemon.tr()}',
    '🍊 ${LocaleKeys.foods_orange.tr()}',
    '🍐 ${LocaleKeys.foods_pear.tr()}',
    '🍍 ${LocaleKeys.foods_pineapple.tr()}',
    '🥔 ${LocaleKeys.foods_potato.tr()}',
    '🍅 ${LocaleKeys.foods_tomato.tr()}',
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.app_title.tr()),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "${LocaleKeys.home_app_desc_1.tr()}\n${LocaleKeys.home_app_desc_2.tr()}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              const SizedBox(height: 6),

              Text(
                LocaleKeys.home_supported_foods.tr(),
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: supportedFoods
                    .map(
                      (food) => Chip(
                        label: Text(food),
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 60),
              
              ElevatedButton(
                onPressed: viewModel.navigateToTakePictureView,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  LocaleKeys.home_start_button.tr(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
