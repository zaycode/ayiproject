import 'package:ayi/core/components/button.dart';
import 'package:ayi/core/components/edit_text.dart';
import 'package:ayi/module/auth/signup/bloc/signup_bloc.dart';
import 'package:ayi/utils/extension.dart';
import 'package:ayi/utils/ui_utilities.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SignUpStepThree extends StatelessWidget {
  final SignupBloc bloc;
  SignUpStepThree(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: bloc.formKeyStep3,
      child: Column(
        children: [
          EditText(
            label: "occupation".tr(),
            hint: "occupation_hint".tr(),
            validator: (value) {
              if (value.isNullOrEmpty) {
                return "please_select"
                    .tr(namedArgs: {'a': 'occupation'.tr().toLowerCase()});
              }
              return null;
            },
          ),
          EditText(
            label: "company".tr(),
            hint: "company_hint".tr(),
            validator: (value) {
              if (value.isNullOrEmpty) {
                return "please_select"
                    .tr(namedArgs: {'a': 'company'.tr().toLowerCase()});
              }
              return null;
            },
          ),
          EditText(
            controller: bloc.languageC,
            onTap: () async {
              UIUtilities.bottomSheetCheckBox(
                      context: context,
                      title: 'fluently_spoken_language',
                      listData: bloc.languages,
                      initialValue: bloc.languageSelected)
                  .then((value) {
                if (value != null) {
                  bloc.languageSelected = value;
                  print(value.toString());
                  bloc.languageC.text =
                      value.map((e) => e.title).toList().join(",");
                }
              });
            },
            label: "fluently_spoken_language".tr() + "(s)*",
            hint: "add_language".tr(),
            suffix: const Icon(Icons.add_circle_outline),
            validator: (value) {
              if (value.isNullOrEmpty) {
                return "please_select"
                    .tr(namedArgs: {'a': 'language'.tr().toLowerCase()});
              }
              return null;
            },
          ),
          EditText(
            controller: bloc.preferredC,
            onTap: () {
              UIUtilities.bottomSheetLists(
                      context: context,
                      title: 'preferred_service',
                      listData: bloc.preferredServices,
                      initialValue: bloc.preferred)
                  .then((value) => {
                        if (value != null)
                          {
                            bloc.preferred = value.code,
                            bloc.preferredC.text = value.title
                          }
                      });
            },
            label: "preferred_service".tr(),
            hint: "preferred_service_hint".tr(),
            suffix: Icon(Icons.arrow_drop_down_outlined),
            validator: (value) {
              if (value.isNullOrEmpty) {
                return "please_select".tr(
                    namedArgs: {'a': 'preferred_service'.tr().toLowerCase()});
              }
              return null;
            },
          ),
          EditText(
            controller: bloc.aboutC,
            lines: 5,
            label: "tell_us_about_you".tr(),
            hint: "tell_us_about_you_hint".tr(),
            validator: (value) {
              if (value.isNullOrEmpty) {
                return "please_enter"
                    .tr(namedArgs: {'a': 'about'.tr().toLowerCase()});
              }
              return null;
            },
          ),
          Button(
            margin: EdgeInsets.only(top: 16),
            title: "btn_submit".tr(),
            onTap: () {
              bloc.submit();
            },
          ),
        ],
      ),
    );
  }
}
