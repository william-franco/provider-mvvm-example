// Project imports:
import 'package:provider_mvvm_example/src/features/photos/models/photo_model.dart';

sealed class PhotoState {}

final class PhotoInitial extends PhotoState {}

final class PhotoLoading extends PhotoState {}

final class PhotoSuccess extends PhotoState {
  final List<PhotoModel> photos;

  PhotoSuccess({required this.photos});
}

final class PhotoFailure extends PhotoState {
  final String message;

  PhotoFailure({required this.message});
}
