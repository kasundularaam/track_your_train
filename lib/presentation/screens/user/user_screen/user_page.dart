import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/components.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/type_user.dart';
import '../../../../logic/cubit/all_trains_cubit/all_trains_cubit.dart';
import '../../../../logic/cubit/sign_out_cubit/sign_out_cubit.dart';
import '../../../router/app_router.dart';
import 'widgets/user_map.dart';

class UserPage extends StatefulWidget {
  final TypeUser typeUser;
  const UserPage({
    Key? key,
    required this.typeUser,
  }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TypeUser get typeUser => widget.typeUser;
  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<AllTrainsCubit>(context).dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AllTrainsCubit>(context).loadTrains();
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRouter.searchPage),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: AppColors.lightElv0,
                          borderRadius: BorderRadius.circular(2.w),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: textP("Search...", 14, bold: true),
                            ),
                            Icon(
                              Icons.search_rounded,
                              color: AppColors.primaryColor,
                              size: 22.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
                                    Strings.profileImg,
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
                                      "Name:",
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
                                        "vmUser.name",
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
                                        "vmUser.email",
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
                        Strings.profileImg,
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(5.w)),
                child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.lightElv1,
                    ),
                    child: const UserMap()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
