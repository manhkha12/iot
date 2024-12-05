class DeviceState {
  final String lightState;
  final int temperature;
  final int humidity;

  DeviceState({
    required this.lightState,
    required this.temperature,
    required this.humidity,
  });

  DeviceState copyWith({
    String? lightState,
    int? temperature,
    int? humidity,
  }) {
    return DeviceState(
      lightState: lightState ?? this.lightState,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
    );
  }
}