import 'package:iot/gen/assets.gen.dart';
import 'package:iot/localization/localizations.dart';
import 'package:iot/shared/extensions/build_context_extension.dart';

import 'package:iot/shared/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        AppIconButton.outline(
          icon: Assets.icons.google.path,
          label: 'login.login_by_google'.tr(),
          primaryColor: Colors.black,
          isUseOriginalColor: true,
          alignment: MainAxisAlignment.start,
          onPressed: () {},
          spacing: 40,
          textStyle: const TextStyle(fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
        AppIconButton.outline(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          icon: Assets.icons.apple.path,
          label: 'login.login_by_apple'.tr(),
          primaryColor: Colors.black,
          isUseOriginalColor: true,
          alignment: MainAxisAlignment.start,
          onPressed: () {},
          iconSize: 20,
          spacing: 45,
          textStyle: const TextStyle(fontSize: 17),
        ),
        const SizedBox(
          height: 60,
        ),
        RichText(
          text: TextSpan(
            text: 'login.new_member'.tr(),
            style: TextStyle(
              fontSize: 15,
              color: context.colors.black,
            ),
            children: [
              const WidgetSpan(
                child: SizedBox(width: 3),
              ),
              TextSpan(
                text: 'signup.title'.tr(),
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 15,
                  color: context.colors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
