import 'dart:io';

import 'package:ayi/data/repositories/signup_reposiotories_impl.dart';
import 'package:ayi/domain/entity/base_entity.dart';
import 'package:ayi/domain/repository/sign_up_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import 'signup_state.dart';

export 'signup_state.dart';

class SignupBloc extends Cubit<SignupState> {
  final SignUpRepository signUpRepository = SignUpRepositoryImpl();

  SignupBloc() : super(SignupInitialState());

  final formKeyStep3 = GlobalKey<FormState>();
  final formKeyStep2 = GlobalKey<FormState>();

  int currentStep = 0;
  String? gender;

  final birthDateC = TextEditingController();
  final fullNameDateC = TextEditingController();
  final locationC = TextEditingController();
  final phoneC = TextEditingController();
  final languageC = TextEditingController();
  final preferredC = TextEditingController();
  final aboutC = TextEditingController();

  bool isErrorGender = false;
  bool isErrorAvatar = false;
  bool isErrorPhone = false;

  Position? location;
  File? avatarProfile;

  set setGender(String? val) {
    gender = val;
    isErrorGender = false;
    emit(SignupViewChangeState());
  }

  void viewChange() {
    emit(SignupViewChangeState());
  }

  List<String> stepLabel = [
    "select_your_role",
    "personal_information",
    "professional_information"
  ];

  String? preferred;
  List<ChoiceEntity> languageSelected = [];
  List<ChoiceEntity> preferredServices = [
    ChoiceEntity(code: "1", title: "Child Care"),
    ChoiceEntity(code: "2", title: "Home Care"),
    ChoiceEntity(code: "3", title: "Child Care"),
    ChoiceEntity(code: "4", title: "Senior Care"),
    ChoiceEntity(code: "5", title: "Other Services")
  ];
  List<ChoiceEntity> languages = [
    ChoiceEntity(code: "1", title: "Spanish"),
    ChoiceEntity(code: "2", title: "Mandarin"),
    ChoiceEntity(code: "3", title: "English"),
    ChoiceEntity(code: "4", title: "Indonesia"),
    ChoiceEntity(code: "5", title: "Arabic")
  ];
  List<String> genderData = ["male", "female", "other"];

  String phoneSelected = "+62";

  List<String> phoneCodes = [
    "+62",
    "+61",
    "+60",
  ];

  void start() async {
    try {
      Future.delayed(Duration.zero);

      if (kReleaseMode) {
        final currentLoc = await signUpRepository.getCurrentLocation();
        await signUpRepository
            .getAddressFromLatLng(currentLoc.latitude, currentLoc.longitude)
            .then((value) {
          locationC.text = value.name ?? "";
        });
        location = currentLoc;
      } else {
        locationC.text = "Jakarta, Indonesia";
      }
      currentStep += 1;
      emit(SignupViewChangeState());
    } catch (e) {
      print("error $e");
      emit(SignupErrorState());
    }
  }

  void cancel() {
    if (currentStep > 0) {
      currentStep--;
    }
  }

  void pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final image = await _picker.pickImage(source: ImageSource.gallery);
      print("=====Image $image");
      if (image != null) {
        avatarProfile = File(image.path);
        isErrorAvatar = false;
        emit(SignupViewChangeState());
      }
    } catch (e) {
      print("Error $e");
      emit(SignupErrorState());
    }
  }

  void submit() async {
    if (formKeyStep3.currentState!.validate()) {
      emit(SignupLoadingState());
      await Future.delayed(Duration(seconds: 3));
      emit(SignupSuccessState());
    }
  }

  nextStep3() {
    isErrorAvatar = avatarProfile == null;
    isErrorGender = gender == null;
    isErrorPhone = phoneC.text.isEmpty;

    if (formKeyStep2.currentState!.validate() &&
        !isErrorAvatar &&
        !isErrorGender) {
      currentStep += 1;
    }
    emit(SignupViewChangeState());
  }
}
