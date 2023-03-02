import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> _formKey;
  bool isLoginFailed = false;

  LoginCubit(this._formKey, this.emailController, this.passwordController)
      : super(const LoginInitial());

  void postUserModel() {
    if (_formKey.currentState!.validate()) {
      //TODO service call
    } else {
      isLoginFailed = true;
      emit(LoginValidateState(isLoginFailed));
    }
  }
}
