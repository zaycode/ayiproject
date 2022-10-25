import 'package:ayi/config/app_color.dart';
import 'package:ayi/config/const.dart';
import 'package:ayi/core/components/button.dart';
import 'package:ayi/core/components/edit_text.dart';
import 'package:ayi/core/components/error_view.dart';
import 'package:ayi/core/library/datetime_picker/datetime_picker.dart';
import 'package:ayi/module/auth/signup/bloc/signup_bloc.dart';
import 'package:ayi/utils/extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:place_picker/place_picker.dart';

class SignUpStepTwo extends StatelessWidget {
  final SignupBloc bloc;

  SignUpStepTwo(this.bloc);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: bloc.formKeyStep2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _header(context),
          // const SpacerV(),
          // Divider(color: Palette.divider, thickness: Dimens.space1),
          // const SpacerV(),
          // Divider(color: Palette.divider, thickness: Dimens.space1),
          EditText(
            controller: bloc.fullNameDateC,
            label: "full_name".tr(),
            hint: "your_full_name".tr(),
            validator: (value) {
              if (value.isNullOrEmpty) {
                return "please_enter"
                    .tr(namedArgs: {'a': 'full_name'.tr().toLowerCase()});
              }
              return null;
            },
          ),
          _buildGender(context),
          EditText(
            onTap: () {
              DateTimePicker.showDatePicker(context,
                  title: "birth_day",
                  maxTime: DateTime.now(), onConfirm: (date) {
                bloc.birthDateC.text = DateFormat('dd/MM/yyyy').format(date);
              },
                  currentTime: bloc.birthDateC.text.isNotEmpty
                      ? DateFormat("dd/MM/yyyy").parse(bloc.birthDateC.text)
                      : DateTime.now());
            },
            controller: bloc.birthDateC,
            label: "Choose Your Date of Birth",
            bgColor: Colors.white,
            readOnly: true,
            hint: "DD/MM/YYYY",
            validator: (value) {
              if (value.isNullOrEmpty) {
                return "please_select"
                    .tr(namedArgs: {'a': 'birth_day'.tr().toLowerCase()});
              }
              return null;
            },
            suffix: Icon(CupertinoIcons.calendar),
          ),

          phoneWidget(context),

          EditText(
            margin: EdgeInsets.only(top: 16),
            onTap: () async {
              final LocationResult? location = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlacePicker(
                    AppConstants.googleServerKey,
                  ),
                ),
              );
              print("=====Location $location");
              bloc.locationC.text = "Medan, Sumatra Utara, Indonesia";
            },
            controller: bloc.locationC,
            label: "current_location".tr() + "*",
            hint: "find_location_hint".tr(),
            suffix: const Icon(
              Icons.arrow_drop_down_outlined,
            ),
            validator: (value) {
              if (value.isNullOrEmpty) {
                return "please_enter".tr(
                    namedArgs: {'a': 'current_location'.tr().toLowerCase()});
              }
              return null;
            },
          ),

          Button(
            margin: EdgeInsets.only(top: 32),
            title: "btn_next".tr(),
            onTap: () => bloc.nextStep3(),
          )
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    print("====${bloc.avatarProfile}");
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              bloc.avatarProfile == null
                  ? CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.icon,
                      child: CircleAvatar(
                        radius: 40,
                        child: SvgPicture.asset(
                          "assets/images/ic_avatar_placeholder.svg",
                          width: double.maxFinite,
                        ),
                      ),
                    )
                  : ClipOval(
                      child: Image.file(
                        bloc.avatarProfile!,
                        width: 92,
                        height: 92,
                        fit: BoxFit.cover,
                      ),
                    ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () => bloc.pickImage(),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(4),
                            ),
                            side: BorderSide(width: 1, color: AppColors.border),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "add_profile_photo".tr(),
                                style: Theme.of(context).textTheme.bodyText2,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Icon(
                              Icons.add_circle_outline,
                              color: AppColors.icon,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "add_profile_desc".tr(),
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          bloc.isErrorAvatar
              ? ErrorView("please_select"
                  .tr(namedArgs: {'a': 'avatar'.tr().toLowerCase()}))
              : Container(),
        ],
      ),
    );
  }

  Column _buildGender(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "select_your_gender".tr(),
          style: context.textTheme.bodyText2?.copyWith(
              fontWeight: FontWeight.w600, color: AppColors.textTitle),
        ),
        SizedBox(height: 8),
        Row(
          children: bloc.genderData.mapWithIndex((value, index) {
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(
                    right: index != (bloc.genderData.length) - 1 ? 16 : 0),
                child: InkWell(
                  onTap: () {
                    bloc.setGender = value;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: bloc.gender == value
                          ? null
                          : Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: bloc.gender == value ? AppColors.secondary : null,
                    ),
                    height: 48,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 24,
                          child: Icon(
                            bloc.gender != value
                                ? Icons.radio_button_off_outlined
                                : Icons.radio_button_checked_outlined,
                            color: bloc.gender != value
                                ? AppColors.border
                                : Colors.white,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          value.tr(),
                          style: TextStyle(
                            color: bloc.gender == value
                                ? AppColors.white
                                : Color(0xff636366),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        bloc.isErrorGender
            ? ErrorView("please_select"
                .tr(namedArgs: {'a': 'gender'.tr().toLowerCase()}))
            : Container(),
        SizedBox(height: 16),
      ],
    );
  }

  Widget phoneWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "phone_number".tr(),
          style: TextStyle(
            color: Color(0xff2c3131),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: ButtonTheme(
                    alignedDropdown: true,
                    padding: EdgeInsets.zero,
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down),
                      decoration: const InputDecoration(
                        alignLabelWithHint: true,
                        isDense: true,
                        isCollapsed: true,
                        border: InputBorder.none,
                      ),
                      value: bloc.phoneSelected,
                      items: bloc.phoneCodes
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null && value is String) {
                          bloc.phoneSelected = value;
                        }
                      },
                    ),
                  ),
                ),
                VerticalDivider(
                  color: AppColors.border,
                  thickness: 1,
                  indent: 0,
                  endIndent: 0,
                ),
                Expanded(
                  flex: 9,
                  child: TextFormField(
                    controller: bloc.phoneC,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    cursorColor: AppColors.primary,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      isDense: true,
                      hintText: "XXXX XXXX XXXX",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: AppColors.black60),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bloc.isErrorPhone
            ? ErrorView("please_enter"
                .tr(namedArgs: {'a': 'phone_number'.tr().toLowerCase()}))
            : Container(),
      ],
    );
  }
}
