import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref();

  Future<void> toggleLight(String newState) async {
    await _databaseRef.child("Device/Light").set({"Switch": newState});
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
}