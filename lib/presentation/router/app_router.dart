import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_your_train/logic/cubit/landing_screen_cubit/landing_screen_cubit.dart';
import 'package:track_your_train/logic/cubit/login_cubit/login_cubit.dart';
import 'package:track_your_train/logic/cubit/sign_in_cubit/sign_in_cubit.dart';

import '../../core/exceptions/route_exception.dart';
import '../../logic/cubit/get_location_cubit/get_location_cubit.dart';
import '../../logic/cubit/send_location_cubit/send_location_cubit.dart';
import '../screens/driver_screen/driver_page.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/user_screen/user_page.dart';

class AppRouter {
  static const String home = '/';
  static const String userPage = '/userPage';
  static const String driverPage = '/driverPage';
  static const String loginPage = '/loginPage';
  static const String signInPage = '/signInPage';
  static const String landingPage = '/landingPage';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case userPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => GetLocationCubit(),
            child: const UserPage(),
          ),
        );
      case driverPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SendLocationCubit(),
            child: const DriverPage(),
          ),
        );
      case landingPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LandingScreenCubit(),
            child: const DriverPage(),
          ),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const DriverPage(),
          ),
        );
      case signInPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignInCubit(),
            child: const DriverPage(),
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
