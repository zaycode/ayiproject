import 'package:ayi/core/components/step.dart';
import 'package:ayi/module/auth/acknowledge/success_screen.dart';
import 'package:ayi/module/auth/signup/bloc/signup_bloc.dart';
import 'package:ayi/module/auth/signup/signup_step1.dart';
import 'package:ayi/module/auth/signup/signup_step2.dart';
import 'package:ayi/module/auth/signup/signup_step3.dart';
import 'package:ayi/utils/extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SignupBloc _bloc;

  @override
  void initState() {
    _bloc = SignupBloc();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_bloc.currentStep == 0) {
          return true;
        } else {
          _bloc.cancel();
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer(
          bloc: _bloc,
          listener: (context, state) {
            if (state is SignupLoadingState) {
              EasyLoading.show();
            } else {
              EasyLoading.dismiss();
            }

            if (state is SignupSuccessState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const SuccessScreen()),
              );
            }
          },
          builder: (context, state) {
            return StepperCustom(
              type: StepperCustomType.horizontal,
              currentStep: _bloc.currentStep,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).viewPadding.top + 16,
                bottom: 16,
              ),
              controlsBuilder: (context, details) {
                return const SizedBox();
              },
              steps: _bloc.stepLabel.mapWithIndex((value, index) {
                return StepCustom(
                  title: Text(
                    value.tr(),
                    style: Theme.of(context).textTheme.caption?.copyWith(
                          color: _bloc.currentStep > index
                              ? Colors.white
                              : Color(0xffE5E5EA),
                          fontWeight: _bloc.currentStep >= index
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  isActive: _bloc.currentStep >= index,
                  state: _bloc.currentStep > index
                      ? StepStateCustom.complete
                      : StepStateCustom.indexed,
                  content: index == 0
                      ? SigUpStepOne(_bloc)
                      : index == 1
                          ? SignUpStepTwo(_bloc)
                          : SignUpStepThree(_bloc),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
