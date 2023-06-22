import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:sharing_session/models/models.dart';

import '../../repositories/repositories.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository profileRepository;

  ProfileBloc(this.profileRepository) : super(ProfileInitial()) {
    on<LoadDetailProfile>(_loadDetailProfileHandler);
    on<SignIn>(_signInHandler);
  }

  Future<void> _loadDetailProfileHandler(
    LoadDetailProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(DetailProfileLoading());

    try {
      final response = await profileRepository.getUsers();

      emit(DetailProfileLoaded(
        userData: response,
      ));
    } on DioError catch (error) {
      emit(DetailProfileError());
    } catch (error) {
      emit(DetailProfileError());
    }
  }

  Future<void> _signInHandler(
    SignIn event,
    Emitter<ProfileState> emit,
  ) async {
    emit(SignInLoading());

    await Future.delayed(const Duration(seconds: 3));

    emit(SignInSuccess());
  }
}
