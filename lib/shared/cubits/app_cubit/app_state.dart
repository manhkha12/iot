import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  factory AppState.checking() = _AppStateChecking;
  factory AppState.unAuthorized() = _AppStateUnAuthorized;
  factory AppState.authorized() = _AppStateAuthorized;
}
