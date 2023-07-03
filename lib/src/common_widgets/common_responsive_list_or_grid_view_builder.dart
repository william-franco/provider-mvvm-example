// Flutter imports:
import 'package:flutter/material.dart';

class CommonResponsiveListOrGridViewBuilder extends StatelessWidget {
  final int itemCount;
  final Widget? Function(BuildContext, int) itemGridBuilder;
  final Widget? Function(BuildContext, int) itemListBuilder;

  const CommonResponsiveListOrGridViewBuilder({
    super.key,
    required this.itemCount,
    required this.itemGridBuilder,
    required this.itemListBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return constraints.maxWidth > 700
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: constraints.maxWidth > 700 ? 4 : 2,
                  crossAxisSpacing: constraints.maxWidth > 700 ? 40 : 10,
                  mainAxisSpacing: constraints.maxWidth > 700 ? 40 : 10,
                ),
                itemCount: itemCount,
                itemBuilder: itemGridBuilder,
              )
            : ListView.builder(
                itemCount: itemCount,
                itemBuilder: itemListBuilder,
              );
      },
    );
  }
}
