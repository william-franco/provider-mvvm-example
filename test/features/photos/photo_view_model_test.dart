// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:provider_mvvm_example/src/features/photos/repositories/photo_repository.dart';
import 'package:provider_mvvm_example/src/features/photos/state/photo_state.dart';
import 'package:provider_mvvm_example/src/features/photos/view_models/photo_view_model.dart';
import 'package:provider_mvvm_example/src/services/http_service.dart';

void main() {
  group('PhotoViewModel', () {
    late HttpService httpService;
    late PhotoRepository photoRepository;
    late PhotoViewModel photoViewModel;

    setUp(() {
      httpService = HttpServiceImpl();
      photoRepository = PhotoRepositoryImpl(httpService: httpService);
      photoViewModel = PhotoViewModelImpl(photoRepository: photoRepository);
    });

    test('Value should be initial state', () {
      expect(photoViewModel.value, isA<PhotoInitial>());
    });

    test('Value should be success state', () async {
      await photoViewModel.loadPhotos();
      expect(photoViewModel.value, isA<PhotoSuccess>());
    });
  });
}
