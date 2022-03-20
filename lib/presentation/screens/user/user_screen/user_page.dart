import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:track_your_train/logic/cubit/all_trains_cubit/all_trains_cubit.dart';
import 'package:track_your_train/presentation/router/app_router.dart';
import 'package:track_your_train/presentation/screens/user/user_screen/widgets/user_map.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/type_user.dart';
import '../../../../logic/cubit/sign_out_cubit/sign_out_cubit.dart';
import '../../widgets/sign_out_window.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 3.w,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRouter.searchPage),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                      margin: EdgeInsets.symmetric(vertical: 1.5.h),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(2.w)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Search...",
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                            ),
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
                SizedBox(
                  width: 1.w,
                ),
                TextButton(
                  onPressed: () => showModalBottomSheet(
                      context: context,
                      builder: (sheetContext) {
                        return BlocProvider(
                          create: (context) => SignOutCubit(),
                          child: const SignOutWindow(),
                        );
                      }),
                  child: Icon(
                    Icons.more_vert_rounded,
                    color: AppColors.primaryColor,
                    size: 26.sp,
                  ),
                ),
                SizedBox(
                  width: 1.w,
                ),
              ],
            ),
            const Expanded(
              child: UserMap(),
            ),
          ],
        ),
      ),
    );
  }
}
