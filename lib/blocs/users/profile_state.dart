part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class DetailProfileLoading extends ProfileState {}

class DetailProfileLoaded extends ProfileState {
  final Users userData;

  DetailProfileLoaded({
    required this.userData,
  });
}

class DetailProfileError extends ProfileState {}

class SignInLoading extends ProfileState {}

class SignInSuccess extends ProfileState {}

class SignInFailed extends ProfileState {}
