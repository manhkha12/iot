import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot/gen/assets.gen.dart';
import 'package:iot/localization/localizations.dart';
import 'package:iot/shared/enums/trasaction_type.dart';
import 'package:iot/shared/extensions/build_context_extension.dart';
import 'package:iot/shared/models/firebase_service.dart';
import 'package:iot/shared/widgets/app_text.dart';
import 'package:vibration/vibration.dart';

class HomePageFooter extends StatefulWidget {
  const HomePageFooter({super.key});

  @override
  State<HomePageFooter> createState() => _HomePageFooterState();
}

// TransactionType? selectedType = TransactionType.close;

class _HomePageFooterState extends State<HomePageFooter> {
  final FirebaseService firebaseService = FirebaseService();
  double temperature = 0.0;
  double humidity = 0.0;
  double gasValue = 0.0;
  String gasStatus = "...";

  // Trạng thái riêng biệt cho từng nút đèn
  Map<String, TransactionType> lightStates = {
    "Switch": TransactionType.close,
    "Switch1": TransactionType.close,
    "Switch2": TransactionType.close,
    "Switch3": TransactionType.close,
  };
  Map<String, TransactionType> servoStates = {
    "State": TransactionType.close,
  };
// @override
//   void initState() {
//     super.initState();
//     // Ví dụ: Lấy dữ liệu từ Firebase khi màn hình khởi tạo
//     fetchData();
//   }

//   void fetchData() async {
//     final snapshot = await databaseRef.child('devices').get();
//     if (snapshot.exists) {
//       print('Data: ${snapshot.value}');
//     } else {
//       print('No data available.');
//     }
//   }
  void _toggleLight(TransactionType type, String path, String iPath) async {
    final newState =
        lightStates[iPath] == TransactionType.close ? "open" : "close";

    // Gửi dữ liệu mới lên Firebase và chờ phản hồi
    await firebaseService.toggleLight(newState, path, iPath).then((_) {
      // Chỉ cập nhật giao diện sau khi Firebase cập nhật thành công
      setState(() {
        lightStates[iPath] =
            newState == "open" ? TransactionType.opend : TransactionType.close;
      });
    }).catchError((error) {
      print("Lỗi cập nhật Firebase: $error");
    });
  }

  void _toggleServo(TransactionType type, String path, String iPath) async {
    final newState =
        servoStates[iPath] == TransactionType.close ? "open" : "close";

    // Gửi dữ liệu điều khiển servo lên Firebase
    await firebaseService.toggleLight(newState, path, iPath).then((_) {
      setState(() {
        servoStates[iPath] =
            newState == "open" ? TransactionType.opend : TransactionType.close;
      });
    }).catchError((error) {
      print("Lỗi khi điều khiển servo: $error");
    });
  }

  void _sendGasAlert() {
    // Rung thiết bị
    try {
      Vibration.vibrate(duration: 2000); // Rung trong 1 giây
    } catch (e) {
      print("Thiết bị không hỗ trợ rung: $e");
    }

    // Phát âm thanh cảnh báo
    try {
      FlutterRingtonePlayer.play(
        android: AndroidSounds.alarm,
        ios: IosSounds.alarm,
        looping: true, // Lặp lại âm thanh
        volume: 1.0, // Âm lượng tối đa
        asAlarm: true, // Đặt làm âm thanh cảnh báo
      );
    } catch (e) {
      print("Không thể phát âm thanh cảnh báo: $e");
    }

    // Tắt âm thanh sau 5 giây
    Future.delayed(const Duration(seconds: 5), () {
      FlutterRingtonePlayer.stop();
    });
  }

  void _listenGasSensorData() {
    firebaseService.listenGasSensorData().listen((dataGas) {
      setState(() {
        gasValue = dataGas['GasValue'] is int
            ? (dataGas['GasValue'] as int).toDouble()
            : dataGas['GasValue'];
        String newStatus = dataGas['Status'] ?? 'unknown';

        // Nếu trạng thái chuyển từ 'normal' sang 'warning', gửi cảnh báo
        if (gasStatus == 'normal' && newStatus == 'warning') {
          _sendGasAlert();
        }

        gasStatus = newStatus;
      });
    });
  }

  void _listenDHTData() {
    firebaseService.listenDHTData().listen((data) {
      setState(() {
        temperature = data['Temp'] ?? 0;
        humidity = data['Humidity'] ?? 0;
      });
    });
  }

  void _listenLightStates() {
    firebaseService.listenLightStates("Device/Light").listen((newStates) {
      setState(() {
        lightStates = newStates; // Cập nhật trạng thái đèn
      });
    });
  }

  void _listenServoStates() {
    firebaseService.listenServoStates("Device/Servo").listen((newStates) {
      setState(() {
        servoStates = newStates;
      });
    });
  }

  // Hàm lấy dữ liệu DHT ban đầu
  Future<void> _fetchInitialData() async {
    try {
      final data = await firebaseService.fetchDHTData();
      setState(() {
        temperature = data['Temp'] ?? 0;
        humidity = data['Humidity'] ?? 0;
      });
      // Lấy dữ liệu GasSensor ban đầu
      final gasData = await firebaseService.fetchGasSensorData();
      setState(() {
        gasValue = gasData['GasValue'] ?? 0;
        gasStatus = gasData['Status'] ?? "unknown";
      });
    } catch (e) {
      print("Lỗi khi lấy dữ liệu ban đầu: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchInitialData(); // Lấy dữ liệu ban đầu
    _listenDHTData(); // Lắng nghe thay đổi dữ liệu
    _listenLightStates();
    _listenGasSensorData();
    _listenServoStates();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(
              child: Card(
                margin: const EdgeInsets.only(
                    left: 10), // Khoảng cách giữa các Card
                elevation: 6, // Đổ bóng cho Card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Góc bo tròn
                ),
                color:
                    context.colors.onlineColor.withOpacity(0.4), // Màu nền Card
                child: Padding(
                  padding:
                      const EdgeInsets.all(16), // Khoảng cách bên trong Card
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Để Card ôm sát nội dung
                    children: [
                      AppText(
                        'Nhiệt độ: $temperature°C',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 8), // Khoảng cách giữa các dòng
                      AppText(
                        'Độ ẩm: $humidity%',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Card hiển thị GIF
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15), // Bo góc
                child: Container(
                  width: 100, // Chiều rộng
                  height: 100, // Chiều cao
                  child: Assets.images.cc.image(), // Hình ảnh GIF
                ),
              ),
            ),
          ]),
          const SizedBox(
            height: 10,
          ),
          AppText(
            'home.house_door'.tr(),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: _TransactionType(
              type: TransactionType.close,
              text: 'DOOR',
              color: context.colors.textError.withOpacity(0.1),
              textColor: context.colors.textError,
              stateKey: "State",
              lightStates: servoStates, // Sử dụng Map trạng thái servo
              onSelect: (type) {
                _toggleServo(type, "Device/Servo", "State");
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // _Divice(
          //     caterogyModel: CaterogyModel(name: 'door', placeHoder: 'light')),
          SizedBox(
            height: 10,
          ),
          AppText(
            'home.living_room'.tr(),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 5,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _TransactionType(
              type: TransactionType.close,
              text: 'LIGHT',
              color: context.colors.textError.withOpacity(0.1),
              stateKey: "Switch",
              textColor: context.colors.textError,
              lightStates: lightStates,
              onSelect: (type) {
                _toggleLight(type, "Device/Light", "Switch");
              },
            ),
            SizedBox(
              width: 50,
            ),
            _TransactionType(
              type: TransactionType.close,
              text: "LIGHT",
              stateKey: "Switch1",
              color: context.colors.textError.withOpacity(0.1),
              textColor: context.colors.textError,
              lightStates: lightStates,
              onSelect: (type) {
                _toggleLight(type, "Device/Light", "Switch1");
              },
            )
          ]),
          AppText(
            'home.bed_room'.tr(),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: _TransactionType(
              type: TransactionType.close,
              text: 'LIGHT',
              color: context.colors.textError.withOpacity(0.1),
              stateKey: "Switch3",
              textColor: context.colors.textError,
              lightStates: lightStates,
              onSelect: (type) {
                _toggleLight(type, "Device/Light", "Switch3");
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          AppText(
            'home.kitchen'.tr(),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: _TransactionType(
              type: TransactionType.close,
              text: 'LIGHT',
              color: context.colors.textError.withOpacity(0.1),
              stateKey: "Switch2",
              textColor: context.colors.textError,
              lightStates: lightStates,
              onSelect: (type) {
                _toggleLight(type, "Device/Light", "Switch2");
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.all(10), // Khoảng cách bên ngoài Card
            elevation: 6, // Đổ bóng
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Góc bo tròn cho Card
            ),
            color: context.colors.onlineColor.withOpacity(0.4), // Màu nền Card
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 12), // Khoảng cách bên trong Card
              child: AppText(
                'Khí gas: $gasValue ppm',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center, // Canh giữa nội dung
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _TransactionType extends StatefulWidget {
  final TransactionType type;
  final String text;
  final Color color;
  final Color textColor;
  final String stateKey; // Key để ánh xạ trạng thái trong Map
  final Map<String, TransactionType> lightStates; // Truyền toàn bộ Map
  final ValueChanged<TransactionType> onSelect; // Hàm callback khi nhấn

  const _TransactionType({
    Key? key,
    required this.type,
    required this.text,
    required this.color,
    required this.textColor,
    required this.stateKey,
    required this.lightStates,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<_TransactionType> createState() => _TransactionTypeState();
}

class _TransactionTypeState extends State<_TransactionType> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.lightStates[widget.stateKey] == widget.type;

    return Container(
      width: 120,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.colors.onlineColor.withOpacity(0.1)),
      child: Row(children: [
        Expanded(child: AppText(widget.text)),
        Expanded(
          child: InkWell(
            onTap: () {
              widget.onSelect(widget.type); // Gọi callback khi nhấn
            },
            child: Container(
              alignment: Alignment.center,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isSelected
                    ? context.colors.placeholderColor.withOpacity(0.1)
                    : widget.color,
              ),
              child: Text(
                isSelected ? "Close" : "Open",
                style: TextStyle(
                  color: isSelected
                      ? context.colors.placeholderColor
                      : widget.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
