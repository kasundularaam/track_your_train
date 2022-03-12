import 'package:flutter/material.dart';

import '../../../router/app_router.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const Duration duration = Duration(seconds: 2);
  void goToHome() =>
      Future.delayed(duration).then((value) => Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRouter.homePage, (route) => false));
  void goToLogin() =>
      Future.delayed(duration).then((value) => Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRouter.loginPage, (route) => false));

  @override
  void initState() {
    super.initState();
    goToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
