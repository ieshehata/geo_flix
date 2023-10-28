import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';

class CustomCircularIndecator extends StatelessWidget {
  const CustomCircularIndecator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: dashBoardColor,
      ),
    );
  }
}
