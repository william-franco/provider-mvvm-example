import 'package:flutter/material.dart';

class CommonResponsiveGridViewBuilder extends StatelessWidget {
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  const CommonResponsiveGridViewBuilder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: constraints.maxWidth > 700 ? 4 : 2,
            crossAxisSpacing: constraints.maxWidth > 700 ? 40 : 10,
            mainAxisSpacing: constraints.maxWidth > 700 ? 40 : 10,
          ),
          itemCount: itemCount,
          itemBuilder: itemBuilder,
        );
      },
    );
  }
}
