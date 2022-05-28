import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/components/components.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/app_user.dart';
import '../../../../logic/cubit/all_trains_cubit/all_trains_cubit.dart';
import '../../../../logic/cubit/sign_out_cubit/sign_out_cubit.dart';
import '../../../router/app_router.dart';
import 'widgets/user_details_view.dart';
import 'widgets/user_map.dart';

class UserPage extends StatefulWidget {
  final AppUser user;
  const UserPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  AppUser get user => widget.user;
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
                          child: UserDetailsView(user: user),
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
                  hSpacer(3),
                  InkWell(
                    onTap: () => navPush(context, AppRouter.bookingsPage),
                    child: ClipOval(
                      child: Image.asset(
                        Strings.ticketsImg,
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
