import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:touski/presentation/views/home/home_viewmodel.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:touski/generated/locale_keys.g.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
           title: Text(LocaleKeys.app_title.tr()),
        ),
        body: Center(
          child: TextButton(
            onPressed: () { viewModel.navigateToTakePictureView();}, 
            child: Text(LocaleKeys.home_start_button.tr())
          )
        )
      )
    );
  }

}