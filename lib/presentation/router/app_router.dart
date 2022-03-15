import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/exceptions/route_exception.dart';
import '../../data/models/type_user.dart';
import '../../logic/cubit/get_location_cubit/get_location_cubit.dart';
import '../../logic/cubit/landing_screen_cubit/landing_screen_cubit.dart';
import '../../logic/cubit/login_cubit/login_cubit.dart';
import '../../logic/cubit/send_location_cubit/send_location_cubit.dart';
import '../../logic/cubit/sign_in_cubit/sign_in_cubit.dart';
import '../screens/auth/landing_screen/landing_page.dart';
import '../screens/auth/login_screen/login_page.dart';
import '../screens/auth/signup_screen/signup_page.dart';
import '../screens/driver/driver_screen/driver_page.dart';
import '../screens/ticket_checker/ticket_checker_screen/ticket_checker_page.dart';
import '../screens/user/user_screen/user_page.dart';

class AppRouter {
  static const String landingPage = '/';
  static const String userPage = '/userPage';
  static const String driverPage = '/driverPage';
  static const String ticketCheckerPage = '/ticketCheckerPage';
  static const String loginPage = '/loginPage';
  static const String signInPage = '/signInPage';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case userPage:
        TypeUser typeUser = settings.arguments as TypeUser;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => GetLocationCubit(),
            child: UserPage(
              typeUser: typeUser,
            ),
          ),
        );
      case driverPage:
        TypeUser typeUser = settings.arguments as TypeUser;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SendLocationCubit(),
            child: DriverPage(
              typeUser: typeUser,
            ),
          ),
        );
      case ticketCheckerPage:
        TypeUser typeUser = settings.arguments as TypeUser;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => GetLocationCubit(),
            child: TicketCheckerPage(
              typeUser: typeUser,
            ),
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
