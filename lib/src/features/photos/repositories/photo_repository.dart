import 'package:provider_mvvm_example/src/environments/environments.dart';
import 'package:provider_mvvm_example/src/features/photos/models/photo_model.dart';
import 'package:provider_mvvm_example/src/services/http_service.dart';

class PhotoRepository {
  final HttpService httpService;

  PhotoRepository({
    required this.httpService,
  });

  Future<PhotoModel> readPhoto(String id) async {
    final response = await httpService.getData(
      path: '${Environments.baseURL}${Environments.photos}/$id',
    );
    try {
      if (response.statusCode == 200) {
        final success = PhotoModel.fromJson(response.data);
        return success;
      } else {
        throw Exception('Failed to load photo. ${response.statusMessage}');
      }
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<List<PhotoModel>> readPhotos() async {
    final response = await httpService.getData(
      path: '${Environments.baseURL}${Environments.photos}',
    );
    try {
      if (response.statusCode == 200) {
        final success =
            (response.data as List).map((e) => PhotoModel.fromJson(e)).toList();
        return success;
      } else {
        throw Exception('Failed to load photos. ${response.statusMessage}');
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
