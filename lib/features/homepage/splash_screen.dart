import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iot/features/homepage/component/home_page_footer.dart';
import 'package:iot/features/homepage/component/home_page_header.dart';
import 'package:iot/shared/extensions/build_context_extension.dart';
import 'package:iot/shared/widgets/app_layout.dart';
const appBarHeight = 60.0;
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: context.colors.primaryBackground,
        body: const CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: appBarHeight,
                automaticallyImplyLeading: false,
                title: HomePageHeader(),
              ),
              SliverToBoxAdapter(
                child: HomePageFooter(),
              )
            ]));
  }
}
