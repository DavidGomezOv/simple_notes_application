import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';

class BaseReactiveService with ListenableServiceMixin {
  final ReactiveValue<bool> loadingReactiveValue = ReactiveValue(false);

  @mustCallSuper
  BaseReactiveService() {
    listenToReactiveValues([
      loadingReactiveValue,
    ]);
  }

  @override
  void listenToReactiveValues(List<dynamic> reactiveValues) {
    for (var reactiveValue in reactiveValues) {
      reactiveValue.listen(
        (value) => notifyListeners(),
      );
    }
  }
}
