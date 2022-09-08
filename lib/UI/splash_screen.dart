import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:southwind/UI/auth_wrapper.dart';
import 'package:southwind/component/drawe_controller.dart';
import 'package:southwind/data/providers/providers.dart';

class SplashScrren extends StatefulHookWidget {
  SplashScrren({Key? key}) : super(key: key);

  @override
  _SplashScrrenState createState() => _SplashScrrenState();
}

class _SplashScrrenState extends State<SplashScrren> {
  bool nextScreen = false;
  DrawerIndex drawerIndex = DrawerIndex.Home;
  int currentBottomBarIndex = 0;
  int selectedIndex = 0;
  bool is_connect = false;
  @override
  void initState() {
    super.initState();
    load();
    InternetConnectionChecker().onStatusChange.listen((status) {
      final connected = status == InternetConnectionStatus.connected;
      if (connected == false) {
        showSimpleNotification(Text("No Internet Connection"),
        
            duration: Duration(seconds: 10),
            subtitle: Text(
              "kindly check your connection",
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
            trailing: Icon(Icons.wifi_off_rounded),
            background: Colors.red
            // slideDismissDirection:DismissDirection.up
            // position: NotificationPosition.bottom
            );
        is_connect = true;
      }
      if (connected && is_connect) {
        showSimpleNotification(Text("Connected to Internet"),
            duration: Duration(seconds: 5),
            trailing: Icon(Icons.wifi_rounded),
            background: Colors.green);
      }
    });
  }

  load() async {
    Future.delayed(
        Duration(
          seconds: 5,
        ), () {
      setState(() {
        nextScreen = true;
      });
    });
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final authNotifier = useProvider(authProvider);
    final size = MediaQuery.of(context).size;
    return nextScreen
        ? AuthWrapper()
        : Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Image.asset(
                  'assets/images/southwind_logo.png',
                  height: size.height,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
  }
}
