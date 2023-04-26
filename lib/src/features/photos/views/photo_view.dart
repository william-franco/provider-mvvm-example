import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm_example/src/common_widgets/common_padding.dart';
import 'package:provider_mvvm_example/src/common_widgets/common_responsive_grid_view_builder.dart';
import 'package:provider_mvvm_example/src/features/photos/view_models/photo_view_model.dart';

class PhotoView extends StatelessWidget {
  const PhotoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photos'),
      ),
      body: CommonPadding(
        child: RefreshIndicator(
          onRefresh: () {
            return context.read<PhotoViewModel>().refreshPhotos();
          },
          child: FutureBuilder(
            future: context.read<PhotoViewModel>().loadPhotos(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CommonResponsiveGridViewBuilder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final photo = snapshot.data![index];
                    return Card(
                      child: Image.network(photo.thumbnailUrl!),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
