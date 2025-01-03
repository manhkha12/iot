import 'package:firebase_database/firebase_database.dart';
import 'package:iot/shared/enums/trasaction_type.dart';

class FirebaseService {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  Future<void> toggleLight(String newState, String path,String iPath ) async {
    await _databaseRef.child(path).update({iPath: newState});
  }

  Stream<Map<dynamic, dynamic>> listenDHTData() {
    return _databaseRef.child("Device/DHT").onValue.map((event) {
      return event.snapshot.value as Map<dynamic, dynamic>;
    });
  }

  Future<Map<String, dynamic>> fetchDHTData() async {
    final snapshot = await _databaseRef.child("Device/DHT").get();
    if (snapshot.exists) {
      return Map<String, dynamic>.from(snapshot.value as Map);
    } else {
      return {"Temp": 0, "Humidity": 0}; // Giá trị mặc định
    }
  }
  Stream<Map<String, TransactionType>> listenLightStates(String path) {
  final ref = FirebaseDatabase.instance.ref(path);
  return ref.onValue.map((event) {
    final data = Map<String, dynamic>.from(event.snapshot.value as Map);
    return data.map((key, value) {
      return MapEntry(
        key,
        value == "open" ? TransactionType.opend : TransactionType.close,
      );
    });
  });
}

Stream<Map<String, TransactionType>> listenServoStates(String path) {
  final ref = FirebaseDatabase.instance.ref(path);
  return ref.onValue.map((event) {
    final data = Map<String, dynamic>.from(event.snapshot.value as Map);
    return data.map((key, value) {
      return MapEntry(
        key,
        value == "open" ? TransactionType.opend : TransactionType.close,
      );
    });
  });
}


  Stream<Map<dynamic, dynamic>> listenGasSensorData() {
  return _databaseRef.child("Device/GasSensor").onValue.map((event) {
    final data = event.snapshot.value;
    if (data != null && data is Map) {
      // Chuyển đổi các giá trị kiểu int sang double nếu cần
      return data.map((key, value) {
        if (value is int) {
          return MapEntry(key, value.toDouble()); // Chuyển int -> double
        }
        return MapEntry(key, value);
      });
    } else {
      return {"GasValue": 0.0, "Status": "unknown"}; // Sử dụng double mặc định
    }
  });
}

Future<Map<String, dynamic>> fetchGasSensorData() async {
  final snapshot = await _databaseRef.child("Device/GasSensor").get();
  if (snapshot.exists && snapshot.value != null) {
    return Map<String, dynamic>.from(snapshot.value as Map);
  } else {
    return {"GasValue": 0, "Status": "unknown"}; // Giá trị mặc định
  }
}

}