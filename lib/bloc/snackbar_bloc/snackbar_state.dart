import 'package:flutter/foundation.dart';

import 'snackbar_type.dart';

abstract class SnackbarState {
  final String? translationKey;
  final List? params;
  final SnackBarType? type;
  final Key? key;
  SnackbarState({
    this.translationKey,
    this.params,
    this.type,
    this.key,
  });
}

class InitialSnackbarState extends SnackbarState {}

class ShowSnackBarState extends SnackbarState {
  ShowSnackBarState({
    @required translationKey,
    @required type,
    List<dynamic>? params,
    Key? key,
  }) : super(
          translationKey: translationKey,
          type: type,
          params: params ?? [],
          key: key,
        );
}
