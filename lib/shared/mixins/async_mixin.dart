import 'package:async/async.dart';

mixin AsyncMixin {
  CancelableOperation cancelableFutureWrapper<T>(
    Future<T> inner, {
    Function(T)? onSuccess,
    Function(Object)? onError,
    Function()? onCancel,
  }) {
    return CancelableOperation.fromFuture(inner, onCancel: () {
      onCancel?.call();
    }).then(
      (T data) => onSuccess?.call(data),
      onError: (e, st) {
        onError?.call(e);
      },
      propagateCancel: true,
    );
  }
}
