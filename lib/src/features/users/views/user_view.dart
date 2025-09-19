import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider_mvvm_example/src/common/states/state.dart';
import 'package:provider_mvvm_example/src/common/widgets/refresh_button_widget.dart';
import 'package:provider_mvvm_example/src/common/widgets/refresh_indicator_widget.dart';
import 'package:provider_mvvm_example/src/common/widgets/skeleton_refresh_widget.dart';
import 'package:provider_mvvm_example/src/features/settings/routes/setting_routes.dart';
import 'package:provider_mvvm_example/src/features/users/routes/user_routes.dart';
import 'package:provider_mvvm_example/src/features/users/view_models/user_view_model.dart';

class UserView extends StatefulWidget {
  final UserViewModel userViewModel;

  const UserView({super.key, required this.userViewModel});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      widget.userViewModel.getAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Users'),
        actions: [
          RefreshButtonWidget(
            onPressed: () async {
              await widget.userViewModel.getAllUsers();
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              context.push(SettingRoutes.setting);
            },
          ),
        ],
      ),
      body: Center(
        child: RefreshIndicatorWidget(
          onRefresh: () async {
            await widget.userViewModel.getAllUsers();
          },
          child: ListenableBuilder(
            listenable: widget.userViewModel,
            builder: (context, child) {
              return switch (widget.userViewModel.userState) {
                InitialState() => const Text('List is empty.'),
                LoadingState() => ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return const SkeletonRefreshWidget();
                  },
                ),
                SuccessState(data: final users) => ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = users[index];
                    return InkWell(
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(user.name![0].toUpperCase()),
                          ),
                          title: Text(user.name ?? ''),
                          subtitle: Text(user.email ?? ''),
                        ),
                      ),
                      onTap: () {
                        context.push(UserRoutes.userDetail, extra: user);
                      },
                    );
                  },
                ),
                ErrorState(message: final message) => Text(message),
              };
            },
          ),
        ),
      ),
    );
  }
}
