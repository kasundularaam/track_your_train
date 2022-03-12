import 'package:flutter/material.dart';

import '../../router/app_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRouter.userPage),
                child: const Text("User"),
              ),
              const SizedBox(
                height: 100,
              ),
              TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, AppRouter.driverPage),
                child: const Text("Driver"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
