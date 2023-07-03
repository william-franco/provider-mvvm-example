// Project imports:
import 'package:provider_mvvm_example/src/environments/environments.dart';
import 'package:provider_mvvm_example/src/exception_handling/exception_handling.dart';
import 'package:provider_mvvm_example/src/features/photos/models/photo_model.dart';
import 'package:provider_mvvm_example/src/services/http_service.dart';

abstract interface class PhotoRepository {
  Future<Result<PhotoModel, Exception>> readPhoto(String id);
  Future<Result<List<PhotoModel>, Exception>> readPhotos();
}

class PhotoRepositoryImpl implements PhotoRepository {
  final HttpService httpService;

  PhotoRepositoryImpl({
    required this.httpService,
  });

  @override
  Future<Result<PhotoModel, Exception>> readPhoto(String id) async {
    try {
      final response = await httpService.getData(
        path: '${Environments.baseURL}${Environments.photos}$id',
      );
      switch (response.statusCode) {
        case 200:
          final success = PhotoModel.fromJson(response.data);
          return Success(value: success);
        default:
          return Failure(exception: Exception(response.statusMessage));
      }
    } on Exception catch (error) {
      return Failure(exception: error);
    }
  }

  @override
  Future<Result<List<PhotoModel>, Exception>> readPhotos() async {
    try {
      final response = await httpService.getData(
        path: '${Environments.baseURL}${Environments.photos}',
      );
      switch (response.statusCode) {
        case 200:
          final success = (response.data as List)
              .map((e) => PhotoModel.fromJson(e))
              .toList();
          return Success(value: success);
        default:
          return Failure(exception: Exception(response.statusMessage));
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
