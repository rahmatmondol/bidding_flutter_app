import 'dart:ui';

import 'package:flutter/material.dart';

import 'custom_loading_dialog_widget.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final String? loadingMessage;
  final Widget child;

  const LoadingOverlay({
    Key? key,
    required this.isLoading,
    this.loadingMessage,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.2),
              child: Center(
                child: CustomLoadingWidget(
                  message: loadingMessage ?? "Loading",
                ),
              ),
            ),
          ),
      ],
    );
  }
}
