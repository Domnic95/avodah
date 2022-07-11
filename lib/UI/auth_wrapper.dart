import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:southwind/UI/home/custom_drawer.dart';
import 'package:southwind/UI/login/log_in.dart';
import 'package:southwind/data/providers/providers.dart';

class AuthWrapper extends HookWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authNotifier = useProvider(authProvider);
    if (authNotifier.isLogedIn) {
      return CustomDrawer();
    }
    return Log_In();
  }
}
