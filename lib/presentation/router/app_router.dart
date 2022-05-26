import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/exceptions/route_exception.dart';
import '../../data/models/app_user.dart';
import '../../data/models/train_details.dart';
import '../../data/models/type_user.dart';
import '../../logic/cubit/all_trains_cubit/all_trains_cubit.dart';
import '../../logic/cubit/booking_cubit/booking_cubit.dart';
import '../../logic/cubit/check_tickets_cubit/check_tickets_cubit.dart';
import '../../logic/cubit/landing_screen_cubit/landing_screen_cubit.dart';
import '../../logic/cubit/login_cubit/login_cubit.dart';
import '../../logic/cubit/register_cubit/register_cubit.dart';
import '../../logic/cubit/search_trains_cubit/search_trains_cubit.dart';
import '../../logic/cubit/send_location_cubit/send_location_cubit.dart';
import '../screens/auth/landing_screen/landing_page.dart';
import '../screens/auth/login_screen/login_page.dart';
import '../screens/auth/signup_screen/signup_page.dart';
import '../screens/driver/driver_screen/driver_page.dart';
import '../screens/ticket_checker/ticket_checker_screen/ticket_checker_page.dart';
import '../screens/user/book_train_screen/book_train_page.dart';
import '../screens/user/search_screen/search_page.dart';
import '../screens/user/tracking_screen/tracking_page.dart';
import '../screens/user/user_screen/user_page.dart';

class AppRouter {
  static const String landingPage = '/';
  static const String userPage = '/userPage';
  static const String driverPage = '/driverPage';
  static const String ticketCheckerPage = '/ticketCheckerPage';
  static const String loginPage = '/loginPage';
  static const String signInPage = '/signInPage';
  static const String searchPage = '/searchPage';
  static const String trackingPage = '/trackingPage';
  static const String bookTrainPage = '/bookTrainPage';

  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case userPage:
        final AppUser user = settings.arguments as AppUser;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AllTrainsCubit(),
              ),
            ],
            child: UserPage(
              user: user,
            ),
          ),
        );
      case driverPage:
        final AppUser user = settings.arguments as AppUser;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SendLocationCubit(),
              ),
            ],
            child: DriverPage(
              user: user,
            ),
          ),
        );
      case ticketCheckerPage:
        TypeUser typeUser = settings.arguments as TypeUser;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CheckTicketsCubit(),
            child: TicketCheckerPage(
              user: typeUser,
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
            create: (context) => RegisterCubit(),
            child: const SignInPage(),
          ),
        );
      case searchPage:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SearchTrainsCubit(),
              ),
            ],
            child: const SearchPage(),
          ),
        );
      case trackingPage:
        TrainDetails trainDetails = settings.arguments as TrainDetails;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => SearchTrainsCubit(),
              ),
            ],
            child: TrackingPage(trainDetails: trainDetails),
          ),
        );
      case bookTrainPage:
        TrainDetails trainDetails = settings.arguments as TrainDetails;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => BookingCubit(),
              ),
            ],
            child: BookTrainPage(trainDetails: trainDetails),
          ),
        );
      default:
        throw const RouteException('Route not found!');
    }
  }
}
