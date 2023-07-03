// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:provider_mvvm_example/src/exception_handling/exception_handling.dart';
import 'package:provider_mvvm_example/src/features/photos/repositories/photo_repository.dart';
import 'package:provider_mvvm_example/src/features/photos/state/photo_state.dart';

abstract base class PhotoViewModel extends ValueNotifier<PhotoState> {
  PhotoViewModel() : super(PhotoInitial());

  Future<void> loadPhotos();
}

base class PhotoViewModelImpl extends ValueNotifier<PhotoState>
    implements PhotoViewModel {
  final PhotoRepository photoRepository;

  PhotoViewModelImpl({
    required this.photoRepository,
  }) : super(PhotoInitial());

  @override
  Future<void> loadPhotos() async {
    value = PhotoLoading();
    final result = await photoRepository.readPhotos();
    final photos = switch (result) {
      Success(value: final photos) => PhotoSuccess(photos: photos),
      Failure(exception: final exception) =>
        PhotoFailure(message: 'Something went wrong: $exception'),
    };
    value = photos;
    _debug();
    notifyListeners();
  }

  void _debug() {
    log('Photo state: $value');
  }
}
