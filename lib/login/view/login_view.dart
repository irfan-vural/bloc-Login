import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../viewmodel/login_cubit.dart';
import '../viewmodel/login_state.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LoginCubit(_formKey, emailController, passwordController),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, LoginState state) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Form(
          key: _formKey,
          autovalidateMode: state is LoginValidateState
              ? (state.isValidate
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled)
              : AutovalidateMode.disabled,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildEmailTextField(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              buildPasswordTextField(),
              ElevatedButton(
                onPressed: () {
                  context.read<LoginCubit>().postUserModel();
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ));
  }

  TextFormField buildPasswordTextField() {
    return TextFormField(
      controller: passwordController,
      validator: (value) =>
          value!.length < 8 ? 'Password must be at least 8   characters' : null,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Password'),
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      controller: emailController,
      validator: (value) =>
          value!.length < 6 ? 'Email must be at least 6 characters' : null,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Email'),
    );
  }
}
