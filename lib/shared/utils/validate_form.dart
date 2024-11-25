import 'package:iot/localization/localizations.dart';

class Validation {
  Validation();

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'login.validate.incorrect_email'.tr();
    }

    return null;
  }

  static String? validatePass(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.isNotEmpty && value.length < 6) {
      return 'login.validate.incorrect_pass'.tr();
    }

    return null;
  }

  static String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.isNotEmpty && value.length < 3) {
      return 'login.validate.incorrect_userName'.tr();
    }
    return null;
  }
  static String? validateRePass(String? value,String? originalPass){
    if(value== null || value.isEmpty){
      return null;
    }
    if(value.isNotEmpty&& value!= originalPass){
      return 'login.validate.pass_doesnt_match'.tr();
    }
    return null;
  }
}
