import 'package:cash/util/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data/repository/onboarding_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isFirstTime = await OnboardingRepository().checkFirstTime();
  runApp(MyApp(isFirstLaunch: isFirstTime));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isFirstLaunch});

  final bool isFirstLaunch;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.yellow),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: isFirstLaunch ? AppRoutes.welcome : AppRoutes.home,
    );
  }
}
