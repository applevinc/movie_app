import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/src/core/assets/icons.dart';
import 'package:movie_app/src/core/styles/theme.dart';
import 'package:movie_app/src/core/utils/navigator.dart';
import 'package:movie_app/src/models/failure.dart';
import 'package:movie_app/src/service_locator.dart';
import 'package:movie_app/src/ui/screens/movies/controllers/genres_controller.dart';
import 'package:movie_app/src/ui/screens/movies/controllers/movies_controller.dart';
import 'package:movie_app/src/ui/widgets/dashboard_view.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => serviceLocator<MoviesController>()),
        ChangeNotifierProvider(create: (_) => serviceLocator<GenresController>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 640),
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            title: 'Movie App',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.theme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _fetchGenres();
    Timer(
      const Duration(seconds: 3),
      () => AppNavigator.to(context, const DashboardView()),
    );
  }

  void _fetchGenres() async {
    try {
      Future.wait([context.read<GenresController>().fetchGenres()]);
    } on Failure catch (error) {
      log(error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SvgPicture.asset(AppIcons.splash),
      ),
    );
  }
}
