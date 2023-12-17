import 'package:apple_store/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoeadingAnimation extends StatelessWidget {
  const LoeadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: LoadingIndicator(
        indicatorType: Indicator.ballRotateChase,

        /// Required, The loading type of the widget
        colors: const [CustomColors.blue],

        /// Optional, The color collections
        strokeWidth: 2,
      ),
    );
  }
}
