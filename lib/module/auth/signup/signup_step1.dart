import 'package:ayi/config/app_color.dart';
import 'package:ayi/core/components/button.dart';
import 'package:ayi/module/auth/signup/bloc/signup_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SigUpStepOne extends StatelessWidget {
  final SignupBloc bloc;

  SigUpStepOne(this.bloc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 24),
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/images/ic_helper.svg",
            width: 120,
          ),
          SizedBox(height: 24),
          Text(
            "find_a_helper_desc".tr(),
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Button(
            title: "btn_find_a_helper".tr(),
            onTap: () => bloc.start(),
          ),
          SizedBox(height: 60),
          SvgPicture.asset("assets/images/ic_job.svg"),
          SizedBox(height: 24),
          Text(
            "find_for_a_job_desc".tr(),
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Button(
            title: "btn_find_for_a_job".tr(),
            onTap: () => bloc.submit(),
            bgColor: AppColors.secondary,
          ),
        ],
      ),
    );
  }
}
