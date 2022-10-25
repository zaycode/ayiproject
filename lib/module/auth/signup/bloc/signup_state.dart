import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  final int time;

  SignupState() : time = DateTime.now().millisecondsSinceEpoch;

  @override
  List<Object?> get props => [time];
}

class SignupInitialState extends SignupState {}

class SignupViewChangeState extends SignupState {}

class SignupSuccessState extends SignupState {}

class SignupErrorState extends SignupState {}

class SignupLoadingState extends SignupState {}
