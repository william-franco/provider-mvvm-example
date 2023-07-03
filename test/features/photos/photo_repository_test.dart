// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:provider_mvvm_example/src/features/photos/models/photo_model.dart';
import 'package:provider_mvvm_example/src/features/photos/repositories/photo_repository.dart';
import 'package:provider_mvvm_example/src/services/http_service.dart';

void main() {
  group('PhotoRepository', () {
    late HttpService httpService;
    late PhotoRepository photoRepository;

    setUp(() {
      httpService = HttpServiceImpl();
      photoRepository = PhotoRepositoryImpl(httpService: httpService);
    });

    test('Value expected should be an item of type PhotoModel', () async {
      final photo = await photoRepository.readPhoto('1');
      expect(photo, isA<PhotoModel>());
    });

    test('Value expected should be an item of type List<PhotoModel>', () async {
      final photos = await photoRepository.readPhotos();
      expect(photos, isA<List<PhotoModel>>());
    });
  });
}
