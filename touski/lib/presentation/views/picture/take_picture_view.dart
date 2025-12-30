import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:touski/generated/locale_keys.g.dart';
import 'package:touski/main.dart';
import 'package:touski/presentation/views/picture/take_picture_viewmodel.dart';

class TakePictureView extends StatefulWidget {
  const TakePictureView({super.key});

  @override
  State<TakePictureView> createState() => _TakePictureViewState();
}

class _TakePictureViewState extends State<TakePictureView> {
  late CameraController _controller;
  late Future<void> _initCamera;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      cameras.first,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );
    _initCamera = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TakePictureViewModel>.reactive(
      viewModelBuilder: () => TakePictureViewModel(),
      disposeViewModel: false,
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(title: Text(LocaleKeys.picture_title.tr())),
          body: Center(
            child: viewModel.isBusy
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: 320,
                              height: 320,
                              child: viewModel.image != null
                                  ? Image.memory(
                                      viewModel.image!,
                                      fit: BoxFit.cover,
                                    )
                                  : FutureBuilder(
                                      future: _initCamera,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return CameraPreview(_controller);
                                        }
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      viewModel.image == null
                          ? SizedBox(
                              width: double.infinity,
                              height: 90,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      final image = await _controller
                                          .takePicture();
                                      viewModel.setTakenPicture(image);
                                    },
                                    child: Container(
                                      width: 72,
                                      height: 72,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.grey.shade700,
                                          width: 4,
                                        ),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    right: 16,
                                    child: IconButton(
                                      icon: const Icon(Icons.photo_library),
                                      color: Colors.grey.shade700,
                                      iconSize: 36,
                                      tooltip: LocaleKeys.picture_import_button.tr(),
                                      onPressed: viewModel.importPicture,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              children: [
                                Text(viewModel.detectedFoods!.join(', ')),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 180,
                                      child: ElevatedButton(
                                        onPressed: viewModel.retakePicture,
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                        ),
                                        child: Text(
                                          LocaleKeys.picture_retake_button.tr(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),

                                    SizedBox(
                                      width: 180, 
                                      child: ElevatedButton(
                                        onPressed:
                                            viewModel.navigateToRecipeView,
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                        ),
                                        child: Text(
                                          LocaleKeys.picture_recipe_button.tr(),
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
