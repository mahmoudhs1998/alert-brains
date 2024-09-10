import 'package:alert_brains/app/modules/games/xo/constants/constant.dart';
import 'package:alert_brains/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../utils/config.dart';
import '../widgets/app_footer.dart';
import '../widgets/appbar.dart';
class CustomLayout extends StatelessWidget {
  final Widget child;
  const CustomLayout({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: AppColors.primaryPurple.withOpacity(0.5),
          child: Column(
            children: [
              // const AppBarWidget(),
              child,
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 3),
                // child: const AppFooterWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
