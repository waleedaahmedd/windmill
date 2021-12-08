import 'package:flutter/material.dart';
import 'package:windmill_general_trading/views/utils/utils_exporter.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          Container(color: AppColors.appBlackColor.withOpacity(0.05)),
          Center(
            child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(AppColors.appBlueColor),
            ),
          ),
        ],
      ),
    );
  }
}
