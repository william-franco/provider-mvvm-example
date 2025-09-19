import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider_mvvm_example/src/features/users/models/user_model.dart';
import 'package:provider_mvvm_example/src/features/users/view_models/user_view_model.dart';
import 'package:provider_mvvm_example/src/features/users/views/user_detail_view.dart';
import 'package:provider_mvvm_example/src/features/users/views/user_view.dart';

class UserRoutes {
  static String get users => '/users';
  static String get userDetail => '/users-detail';

  List<GoRoute> get routes => _routes;

  final List<GoRoute> _routes = [
    GoRoute(
      path: users,
      builder: (context, state) {
        return UserView(userViewModel: context.read<UserViewModel>());
      },
    ),
    GoRoute(
      path: userDetail,
      builder: (context, state) {
        final UserModel userModel = state.extra as UserModel;

        return UserDetailView(userModel: userModel);
      },
    ),
  ];
}
