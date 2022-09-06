import 'package:arcopen_enquirer/core/base_controller.dart';
import 'package:arcopen_enquirer/utils/helpers/loading_state.dart';
import 'package:arcopen_enquirer/widgets/buttons/k_button.dart';
import 'package:flutter/material.dart';
import 'package:okito/okito.dart';

typedef RetryCallback = Function();

class PageSkeleton<T extends BaseController> extends StatelessWidget {
  const PageSkeleton({
    Key? key,
    required this.child,
    required this.controller,
    required this.retryCallback,
  }) : super(key: key);

  final T controller;
  final Widget child;
  final RetryCallback retryCallback;

  @override
  Widget build(BuildContext context) {
    Widget pageContent = const SizedBox();

    switch (controller.state) {
      case LoadingState.failed:
        pageContent = _PageStateContainer(
          child: KButton(
            onPressed: retryCallback,
            title: "Try again",
            color: Okito.theme.primaryColor,
          ),
        );
        break;
      case LoadingState.loading:
        pageContent = _PageStateContainer(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Container(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(),
            ),
          ),
        );
        break;
      case LoadingState.success:
        pageContent = child;
        break;
      case LoadingState.pending:
        pageContent = const SizedBox();
        break;
    }
    return pageContent;
  }
}

class _PageStateContainer extends StatelessWidget {
  const _PageStateContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AspectRatio(aspectRatio: 10 / 2),
        child,
      ],
    );
  }
}
