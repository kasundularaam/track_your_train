import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_your_train/logic/cubit/landing_screen_cubit/landing_screen_cubit.dart';
import 'package:track_your_train/logic/cubit/login_cubit/login_cubit.dart';
import 'package:track_your_train/logic/cubit/sign_in_cubit/sign_in_cubit.dart';
import 'package:track_your_train/presentation/screens/auth/landing_screen/landing_page.dart';
import 'package:track_your_train/presentation/screens/auth/login_screen/login_page.dart';
import 'package:track_your_train/presentation/screens/auth/signup_screen/signup_page.dart';

import '../../core/exceptions/route_exception.dart';
import '../../logic/cubit/get_location_cubit/get_location_cubit.dart';
import '../../logic/cubit/send_location_cubit/send_location_cubit.dart';
import '../screens/driver_screen/driver_page.dart';
import '../screens/home_screen/home_page.dart';
import '../screens/user_screen/user_page.dart';

class AppRouter {
  static const String landingPage = '/';
  static const String homePage = '/homePage';
  static const String userPage = '/userPage';
  static const String driverPage = '/driverPage';
  static const String loginPage = '/loginPage';
  static const String signInPage = '/signInPage';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
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
            child: const LandingPage(),
          ),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginPage(),
          ),
        );
      case signInPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SignInCubit(),
            child: const SignInPage(),
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
