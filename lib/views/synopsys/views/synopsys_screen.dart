import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:cash/views/settings/views/settings_screen.dart';
import 'package:cash/views/synopsys/widgets/options_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../data/model/news_model.dart';
import '../../../util/shared_pref_service.dart';
import '../../app/widgets/chosen_action_button_widget.dart';
import '../../news/views/news_screen.dart';
import '../../operation/views/constructor_screen.dart';
import '../../statistics_screen/views/statistics_screen.dart';
import '../widgets/operation_list_view.dart';

class SynopsysScreen extends StatefulWidget {
  @override
  _SynopsysScreenState createState() => _SynopsysScreenState();
}

class _SynopsysScreenState extends State<SynopsysScreen> {
  List<Map<String, dynamic>> operations = [];

  @override
  void initState() {
    super.initState();
    _loadOperations();
  }

  void _loadOperations() async {
    operations = await SharedPreferencesService.loadOperations();
    setState(() {});
  }

  void _addOperation(Map<String, dynamic> operation) async {
    setState(() {
      operations.add(operation);
    });
    await SharedPreferencesService.saveOperations(operations);
  }

  double get _totalIncome {
    return operations
        .where((op) => op['type'] == 'Income')
        .fold(0, (prev, op) => prev + op['amount']);
  }

  double get _totalSpendings {
    return operations
        .where((op) => op['type'] == 'Spendings')
        .fold(0, (prev, op) => prev + op['amount']);
  }

  double _totalAmount() {
    double totalIncome = _totalIncome;
    double totalSpendings = _totalSpendings;

    return totalIncome - totalSpendings;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              icon: SvgPicture.asset('assets/icons/settings.svg')),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    //  mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Balance',
                                    style:
                                        HomeScreenTextStyle.incomeBannerTitle,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '\$${_totalAmount().toString()}',
                              style: HomeScreenTextStyle.bannerIncome,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Income',
                                  style: HomeScreenTextStyle.incomeBannerTitle,
                                  textAlign: TextAlign.center,
                                ),
                                Spacer(),
                                Text(
                                  '\$$_totalIncome ',
                                  style: HomeScreenTextStyle.bannerSpendings,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        indent: 6,
                        endIndent: 8,
                        height: 1.0,
                        thickness: 0.2,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Expense',
                                  style: HomeScreenTextStyle.incomeBannerTitle,
                                  textAlign: TextAlign.center,
                                ),
                                const Spacer(),
                                Text(
                                  '\$$_totalSpendings ',
                                  style: HomeScreenTextStyle.bannerSpendings,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        indent: 6,
                        endIndent: 8,
                        height: 1.0,
                        thickness: 0.2,
                        color: Colors.grey,
                      ),
                      ChosenActionButton(
                        text: 'Refill balance',
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConstructorScreen()),
                          );
                          if (result != null) {
                            _addOperation(result);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OptionsWidget(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewsScreen(
                                    newsModel: news,
                                  )),
                        );
                      },
                      icon: 'assets/icons/news.svg',
                      title: 'News',
                      subtitle: '6 news'),
                  const SizedBox(width: 10),
                  OptionsWidget(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StatisticScreen()),
                        );
                      },
                      icon: 'assets/icons/statistics.svg',
                      title: 'Statistics',
                      subtitle:
                          'Statistics of your current income and expense.'),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                  height: size.height * 0.4,
                  child: OperationsListView(operations: operations)),
            ],
          ),
        ),
      ),
    );
  }
}

class Pxamifds extends StatefulWidget {
  final String gfdgdfg;
  final String hkjhkhjk;
  final String lkjbhgvdf;

  Pxamifds(
      {required this.gfdgdfg, required this.hkjhkhjk, required this.lkjbhgvdf});

  @override
  State<Pxamifds> createState() => _PxamifdsState();
}

class _PxamifdsState extends State<Pxamifds> {
  late AppsflyerSdk _appsflyerSdk;
  String adId = '';
  bool _isFirstLaunch = false;
  String dexsc = '';
  String authxa = '';
  String _afStatus = '';
  Map _deepLinkData = {};
  Map _gcd = {};

  @override
  void initState() {
    super.initState();
    getTracking();
    initAppsflyerSdk();
  }

  Future<void> initAppsflyerSdk() async {
    final AppsFlyerOptions options = AppsFlyerOptions(
      showDebug: false,
      afDevKey: 'doJsrj8CyhTUWPZyAYTByE',
      appId: '6503913797',
      timeToWaitForATTUserAuthorization: 15,
      disableAdvertisingIdentifier: false,
      disableCollectASA: false,
      manualStart: true,
    );
    _appsflyerSdk = AppsflyerSdk(options);

    await _appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );

    _appsflyerSdk.onAppOpenAttribution((res) {
      setState(() {
        _deepLinkData = res;
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
    });

    _appsflyerSdk.onInstallConversionData((res) {
      setState(() {
        _gcd = res;
        _isFirstLaunch = res['payload']['is_first_launch'];
        _afStatus = res['payload']['af_status'];
        dexsc = '&is_first_launch=$_isFirstLaunch&af_status=$_afStatus';
        print(dexsc);
      });
    });

    _appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
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
      setState(() {
        _deepLinkData = dp.toJson();
      });
    });

    _appsflyerSdk.startSDK(
      onSuccess: () {
        print("AppsFlyer SDK initialized successfully.");
      },
    );

    await fetchDatax();
  }

  Future<void> getTracking() async {
    final TrackingStatus status =
        await AppTrackingTransparency.requestTrackingAuthorization();
    print(status);
  }

  Future<void> fetchDatax() async {
    try {
      adId = await _appsflyerSdk.getAppsFlyerUID() ?? '';
      adId = '&appsflyer_id=$adId';
      print("AppsFlyer ID: $adId");
    } catch (e) {
      print("Failed to get AppsFlyer ID: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final fsdfsd = '${widget.gfdgdfg}${widget.lkjbhgvdf}${widget.hkjhkhjk}';
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(fsdfsd),
          ),
        ),
      ),
    );
  }
}
