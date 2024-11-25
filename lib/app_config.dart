import 'package:equatable/equatable.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _envLocalKey = 'family_4_0.env';

Future<AppConfig> getCurrentConfigs() async {
  final variables = FlutterConfig.variables;
  return AppConfig(
    appName: variables['APP_NAME'],
    appEnv: variables['ENV'],
    baseApiUrl: variables['BASE_API_URL'],
    mediaUrl: variables['MEDIA_URL'],
  );
}

Future<void> saveConfig(AppConfig config) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_envLocalKey, config.appEnv);
}

class AppConfig extends Equatable {
  final String appName;
  final String appEnv;
  final String baseApiUrl;
  final String mediaUrl;

  const AppConfig({
    required this.appName,
    required this.appEnv,
    required this.baseApiUrl,
    required this.mediaUrl,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) {
    return AppConfig(
      appName: json['app_name'],
      appEnv: json['env'],
      baseApiUrl: json['base_api_url'],
      mediaUrl: json['media_url'],
    );
  }

  String get termLink => 'https://banti.app/service-terms.html';
  String get privacyLink => 'https://banti.app/privacy-policy.html';
  String get helpLink => 'https://banti.app/contact-help.html';

  @override
  List<Object?> get props => [appEnv, baseApiUrl, mediaUrl];
}
