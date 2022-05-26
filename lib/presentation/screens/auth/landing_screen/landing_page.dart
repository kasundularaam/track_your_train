import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/components/components.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../logic/cubit/landing_screen_cubit/landing_screen_cubit.dart';
import '../../../router/app_router.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LandingScreenCubit>(context).startApp();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset("assets/images/landing.gif"),
              SizedBox(
                height: 5.h,
              ),
              BlocConsumer<LandingScreenCubit, LandingScreenState>(
                listener: (context, state) {
                  if (state is LandingScreenUser) {
                    navAndClear(context, AppRouter.userPage, args: state.user);
                  }
                  if (state is LandingScreenTrain) {
                    navAndClear(context, AppRouter.driverPage,
                        args: state.user);
                  }
                  if (state is LandingScreenToAuth) {
                    navAndClear(context, AppRouter.loginPage);
                  }
                  if (state is LandingScreenTicketChecker) {
                    navAndClear(context, AppRouter.ticketCheckerPage,
                        args: state.user);
                  }
                  if (state is LandingScreenFailed) {
                    showSnackBar(context, state.errorMsg);
                  }
                },
                builder: (context, state) {
                  if (state is LandingScreenFailed) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        textD("something went wrong!", 14),
                        vSpacer(2),
                        buttonFilledP(
                            "RETRY",
                            () => BlocProvider.of<LandingScreenCubit>(context)
                                .startApp()),
                      ],
                    );
                  } else {
                    return textP("TRACK YOUR TRAIN", 22, bold: true);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
