import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/themes/app_colors.dart';
import '../../../../data/models/type_user.dart';

class TicketCheckerPage extends StatefulWidget {
  final TypeUser typeUser;
  const TicketCheckerPage({
    Key? key,
    required this.typeUser,
  }) : super(key: key);

  @override
  State<TicketCheckerPage> createState() => _TicketCheckerPageState();
}

class _TicketCheckerPageState extends State<TicketCheckerPage> {
  TypeUser get typeUser => widget.typeUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightElv0,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(typeUser.email),
              SizedBox(
                height: 2.h,
              ),
              Text(typeUser.uid),
              SizedBox(
                height: 2.h,
              ),
              Text(typeUser.typeToString),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
