import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/components.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/app_user.dart';
import '../../../../logic/cubit/send_location_cubit/send_location_cubit.dart';
import '../../../../logic/cubit/sign_out_cubit/sign_out_cubit.dart';
import '../../../router/app_router.dart';
import 'widget/driver_map.dart';

class DriverPage extends StatefulWidget {
  final AppUser user;
  const DriverPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _DriverPageState createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  AppUser get user => widget.user;

  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<SendLocationCubit>(context).dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SendLocationCubit>(context).sendLocation();
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Row(
                children: [
                  Expanded(child: textL(user.userName, 14, bold: true)),
                  hSpacer(3),
                  InkWell(
                    onTap: () => showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(5.w),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      builder: (sheetContext) {
                        return BlocProvider(
                          create: (context) => SignOutCubit(),
                          child: Padding(
                            padding: EdgeInsets.all(5.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                    Strings.driverImg,
                                    width: 30.w,
                                    height: 30.w,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 4.h),
                                  child: const Divider(
                                    color: AppColors.darkElv1,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Train:",
                                      style: TextStyle(
                                          color: AppColors.darkElv0,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        user.userName,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: AppColors.darkElv1,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  children: [
                                    Text(
                                      "Email:",
                                      style: TextStyle(
                                          color: AppColors.darkElv0,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        user.userEmail,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: AppColors.darkElv1,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "remove account from this device:",
                                        style: TextStyle(
                                            color: AppColors.darkElv1,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    BlocConsumer<SignOutCubit, SignOutState>(
                                      listener: (context, state) {
                                        if (state is SignOutFailed) {
                                          SnackBar snackBar = SnackBar(
                                              content: Text(state.errorMsg));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                        if (state is SignOutSucceed) {
                                          Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            AppRouter.landingPage,
                                            (route) => false,
                                          );
                                        }
                                      },
                                      builder: (context, state) {
                                        return ElevatedButton(
                                          onPressed: () =>
                                              BlocProvider.of<SignOutCubit>(
                                                      context)
                                                  .signOut(),
                                          child: const Text(
                                            "SIGN OUT",
                                            style: TextStyle(
                                                color: AppColors.lightElv0),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        Strings.driverImg,
                        width: 13.w,
                        height: 13.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(5.w)),
                  child: const DriverMap()),
            ),
          ],
        ),
      ),
    );
  }
}
