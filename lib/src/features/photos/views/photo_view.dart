// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:provider_mvvm_example/src/common_widgets/common_padding.dart';
import 'package:provider_mvvm_example/src/common_widgets/common_responsive_grid_view_builder.dart';
import 'package:provider_mvvm_example/src/features/photos/state/photo_state.dart';
import 'package:provider_mvvm_example/src/features/photos/view_models/photo_view_model.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({super.key});

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      context.read<PhotoViewModel>().loadPhotos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Photos'),
      ),
      body: CommonPadding(
        child: RefreshIndicator(
          onRefresh: () {
            return context.read<PhotoViewModel>().loadPhotos();
          },
          child: Consumer<PhotoViewModel>(
            builder: (context, state, child) {
              return switch (state.value) {
                PhotoInitial() => const Text('List is empty.'),
                PhotoLoading() => const CircularProgressIndicator(),
                PhotoSuccess(photos: final photos) =>
                  CommonResponsiveGridViewBuilder(
                    itemCount: photos.length,
                    itemBuilder: (BuildContext context, int index) {
                      final photo = photos[index];
                      return Card(
                        child: Image.network(photo.thumbnailUrl!),
                      );
                    },
                  ),
                PhotoFailure(message: final message) => Text(message),
              };
            },
          ),
        ),
      ),
    );
  }
}
