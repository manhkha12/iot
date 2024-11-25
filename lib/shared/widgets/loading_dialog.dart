import 'package:flutter/material.dart';

import 'app_circle_loading.dart';

class LoadingDialogManager {
  static LoadingDialogManager? _instance;
  static LoadingDialogManager get instance => _instance ?? (_instance = LoadingDialogManager());

  LoadingDialogManager();

  bool isShowing = false;

  void hideLoading(BuildContext context) {
    if (isShowing) {
      isShowing = false;
      Navigator.of(context).pop();
    }
  }

  void showLoading(BuildContext context) {
    if (!isShowing) {
      isShowing = true;
      showLoadingDialog(context).then((_) => isShowing = false);
    }
  }
}

Future<void> showLoadingDialog(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    barrierColor: Colors.black.withOpacity(0.3),
    builder: (_) => const _LoadingDialog(),
  );
}

class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.all(12),
          child: const Center(
            child: AppCircleLoading(),
          ),
        ),
      ],
    );
  }
}
