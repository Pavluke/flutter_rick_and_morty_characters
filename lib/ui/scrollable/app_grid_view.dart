import 'dart:async';

import 'package:flutter/material.dart';

class AppGridView extends StatefulWidget {
  const AppGridView({
    super.key,
    this.onScrollEnd,
    required this.builder,
    required this.itemCount,
    this.onRefresh,
  });

  final void Function()? onScrollEnd;
  final FutureOr<void> Function()? onRefresh;
  final Widget Function(BuildContext context, int index) builder;
  final int itemCount;

  @override
  State<AppGridView> createState() => _AppGridViewState();
}

class _AppGridViewState extends State<AppGridView> {
  late final ScrollController scrollController;
  bool isFABVisible = false;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(onScroll);
  }

  void onScroll() async {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    bool mustShowFAB =
        scrollController.position.pixels >
        MediaQuery.sizeOf(context).height / 4;
    if (scrollController.offset >= scrollController.position.maxScrollExtent) {
      setState(() => isFABVisible = false);
    } else if (mustShowFAB != isFABVisible) {
      setState(() => isFABVisible = mustShowFAB);
    }

    if (maxScroll - currentScroll <= 600) {
      widget.onScrollEnd?.call();
    }

    //if (scrollController.offset >= scrollController.position.maxScrollExtent &&
    //    !scrollController.position.outOfRange) {
    //  await widget.onScrollEnd?.call();
    //}
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.onRefresh != null
            ? RefreshIndicator(
              onRefresh: () async => await widget.onRefresh?.call(),
              child: LayoutBuilder(
                builder: (context, _) => _buildGridView(context),
              ),
            )
            : _buildGridView(context),

        Positioned.fill(
          child: AnimatedAlign(
            duration: Duration(milliseconds: 250),
            alignment: isFABVisible ? Alignment.bottomRight : Alignment(1.5, 1),
            curve: Curves.easeInOut,
            child: Padding(
              padding: const EdgeInsets.only(
                right: kFloatingActionButtonMargin,
                bottom: kFloatingActionButtonMargin * 6,
              ),
              child: SizedBox.square(
                dimension: kBottomNavigationBarHeight,
                child: IconButton.filled(
                  onPressed:
                      () => scrollController.animateTo(
                        0,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      ),
                  icon: Icon(Icons.keyboard_arrow_up),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  GridView _buildGridView(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(bottom: 100, top: 10, right: 10, left: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount:
            MediaQuery.orientationOf(context) == Orientation.portrait ? 2 : 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      controller: scrollController,
      itemBuilder: widget.builder,

      itemCount: widget.itemCount,
    );
  }
}
