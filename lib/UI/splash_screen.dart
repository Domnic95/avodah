import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
  @override
  void initState() {
    super.initState();
    load();
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
              child: Image.asset(
                'assets/images/splash.png',
                height: size.height,
                width: size.width,
                fit: BoxFit.cover,
              ),
            ),
          );
  }
}
