import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot/shared/cubits/divides_cubit/state.dart';

class DeviceCubit extends Cubit<DeviceState> {
  final DatabaseReference databaseRef;

  DeviceCubit(this.databaseRef)
      : super(DeviceState(lightState: "close", temperature: 0, humidity: 0)) {
    _listenToFirebase();
  }

  void _listenToFirebase() {
    databaseRef.child("Device/DHT").onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      emit(state.copyWith(
        temperature: data['Temp'],
        humidity: data['Humidity'],
      ));
    });
  }

  void toggleLight() async {
    final newState = state.lightState == "close" ? "open" : "close";
    await databaseRef.child("Device/Light").set({"Switch": newState});
    emit(state.copyWith(lightState: newState));
  }
}