import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geo_flix/features/splash_screen/splash_view.dart';

import 'core/theme/cubit/cubit.dart';
import 'core/theme/cubit/states.dart';
import 'core/theme/theme_manager.dart';
import 'core/utils/api_service.dart';
import 'core/utils/cache_helper.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp( {super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
    );
  }
}
