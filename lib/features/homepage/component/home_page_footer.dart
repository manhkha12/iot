import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot/gen/assets.gen.dart';

import 'package:iot/localization/localizations.dart';
import 'package:iot/shared/enums/trasaction_type.dart';
import 'package:iot/shared/extensions/build_context_extension.dart';
import 'package:iot/shared/models/firebase_service.dart';
import 'package:iot/shared/widgets/app_layout.dart';
import 'package:iot/shared/widgets/app_text.dart';

class HomePageFooter extends StatefulWidget {
  const HomePageFooter({super.key});

  @override
  State<HomePageFooter> createState() => _HomePageFooterState();
}

TransactionType? selectedType = TransactionType.close;

class _HomePageFooterState extends State<HomePageFooter> {
  final FirebaseService firebaseService = FirebaseService();
  double temperature = 0.0;
  double humidity = 0.0;

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
  void _toggleLight(TransactionType type) async {
    final newState = selectedType == TransactionType.close ? "open" : "close";
    await firebaseService.toggleLight(newState);
    setState(() {
      selectedType = selectedType == TransactionType.close
          ? TransactionType.opend
          : TransactionType.close;
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

  // Hàm lấy dữ liệu DHT ban đầu
  Future<void> _fetchInitialData() async {
    try {
      final data = await firebaseService.fetchDHTData();
      setState(() {
        temperature = data['Temp'] ?? 0;
        humidity = data['Humidity'] ?? 0;
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
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            width: context.width,
            height: 55,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: context.colors.onlineColor.withOpacity(0.2)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 5,
              ),
              AppText('Nhiệt độ: $temperature°C',
                  fontSize: 16, fontWeight: FontWeight.bold),
              SizedBox(
                height: 1,
              ),
              AppText('Độ ẩm: $humidity%',
                  fontSize: 16, fontWeight: FontWeight.bold),
            ]),
          ),
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
          _TransactionType(
            type: TransactionType.close,
            text: 'LIGHT',
            color: context.colors.textError.withOpacity(0.1),
            textColor: context.colors.textError,
            selectedType: selectedType,
            onSelect: (type) {
              _toggleLight(type);
            },
          ),
          AppText(
            'home.bed_room'.tr(),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 10,
          ),
          AppText(
            'home.kitchen'.tr(),
            fontSize: 16,
            fontWeight: FontWeight.bold,
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
  final TransactionType? selectedType; // Trạng thái được chọn
  final ValueChanged<TransactionType> onSelect; // Hàm callback khi nhấn

  const _TransactionType({
    Key? key,
    required this.type,
    required this.text,
    required this.color,
    required this.textColor,
    required this.selectedType,
    required this.onSelect,
  }) : super(key: key);

  @override
  State<_TransactionType> createState() => _TransactionTypeState();
}

class _TransactionTypeState extends State<_TransactionType> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.selectedType == widget.type;

    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
