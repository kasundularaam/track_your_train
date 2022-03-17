import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/themes/app_colors.dart';
import '../../../logic/cubit/sign_out_cubit/sign_out_cubit.dart';
import '../../router/app_router.dart';

class SignOutWindow extends StatelessWidget {
  const SignOutWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 1.h,
        ),
        BlocConsumer<SignOutCubit, SignOutState>(
          listener: (context, state) {
            if (state is SignOutSucceed) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRouter.landingPage, (route) => false);
            }
            if (state is SignOutFailed) {
              SnackBar snackBar = SnackBar(content: Text(state.errorMsg));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            if (state is SignOutLoading) {
              return const CircularProgressIndicator(
                color: AppColors.primaryColor,
              );
            } else {
              return TextButton(
                onPressed: () =>
                    BlocProvider.of<SignOutCubit>(context).signOut(),
                child: const Text(
                  "SIGN OUT",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
              );
            }
          },
        ),
        SizedBox(
          height: 1.h,
        ),
      ],
    );
  }
}
