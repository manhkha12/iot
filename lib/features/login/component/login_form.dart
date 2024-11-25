import 'package:iot/localization/localizations.dart';
import 'package:iot/routes.dart';
import 'package:iot/shared/cubits/login_cubit/login_cubit.dart';
import 'package:iot/shared/cubits/login_cubit/states.dart';
import 'package:iot/shared/extensions/build_context_extension.dart';
import 'package:iot/shared/utils/validate_form.dart';
import 'package:iot/shared/widgets/app_text.dart';
import 'package:iot/shared/widgets/app_text_form_field.dart';
import 'package:iot/shared/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginState();
}

class _LoginState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextFormField(
            autovalidateMode: AutovalidateMode.disabled,
            hintText: 'login.input_email'.tr(),
            validator: (value) {
              return Validation.validateEmail(value);
            },
            onChanged: (value) {
              context.read<LoginCubit>().emailChanged(value);
            },
          ),
          const SizedBox(
            height: 15,
          ),
          AppTextFormField(
            autovalidateMode: AutovalidateMode.disabled,
            obscured: true,
            hintText: 'login.input_password'.tr(),
            validator: (value) {
              return Validation.validatePass(value);
            },
            onChanged: (value) {
              context.read<LoginCubit>().passwordChanged(value);
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: AppText(
              'login.fogot_pass'.tr(),
              color: context.colors.black,
              textDecoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return AppButton(
                onPressed: state.valid
                    ? () {
                        var valid = _formKey.currentState!.validate();
                        if (valid) {
                          Navigator.pushNamed(context, RouteName.splash);
                        }
                      }
                    : null,
                label: 'login.title'.tr(),
                textStyle: const TextStyle(fontSize: 16),
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: AppText(
              'login.or'.tr(),
              textDecoration: TextDecoration.underline,
              color: context.colors.inputBorder,
            ),
          ),
        ],
      ),
    );
  }
}
