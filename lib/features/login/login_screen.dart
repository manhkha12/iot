import 'package:iot/features/login/component/login_footer.dart';
import 'package:iot/features/login/component/login_form.dart';
import 'package:iot/features/login/component/login_header.dart';
import 'package:iot/shared/widgets/app_layout.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const AppLayout(
      child: SingleChildScrollView(
        child: Column(
          children: [
            LoginHeader(),
            Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
              child: Column(
                children: [
                  LoginForm(),
                  LoginFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
