import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseScreen extends StatelessWidget {
  final Color baseColor;
  final Widget body;
  final bool loading;
  final WillPopCallback? onBackPressed;
  final bool topSafeArea;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;

  const BaseScreen({
    Key? key,
    required this.baseColor,
    required this.body,
    this.loading = false,
    this.onBackPressed,
    this.topSafeArea = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: baseColor,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: WillPopScope(
          onWillPop: onBackPressed ?? () async => true,
          child: Stack(
            children: [
              SafeArea(
                top: topSafeArea,
                child: Scaffold(
                  body: body,
                  floatingActionButton: floatingActionButton,
                  floatingActionButtonLocation: floatingActionButtonLocation,
                  bottomNavigationBar: bottomNavigationBar,
                ),
              ),
              Visibility(
                visible: loading,
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  color: Colors.black.withAlpha(70),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
