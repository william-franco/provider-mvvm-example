import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider_mvvm_example/src/features/photos/models/photo_model.dart';
import 'package:provider_mvvm_example/src/features/photos/repositories/photo_repository.dart';

class PhotoViewModel extends ChangeNotifier {
  final PhotoRepository photoRepository;

  PhotoViewModel({
    required this.photoRepository,
  });

  List<PhotoModel> _photos = [];
  List<PhotoModel> get photos => _photos;

  Future<List<PhotoModel>> loadPhotos() async {
    _photos = await photoRepository.readPhotos();
    _debug();
    notifyListeners();
    return _photos;
  }

  Future<void> refreshPhotos() async {
    _photos = await photoRepository.readPhotos();
    _debug();
    notifyListeners();
  }

  void _debug() {
    log('Photos: $_photos');
  }
}
