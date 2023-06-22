import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharing_session/blocs/blocs.dart';

import '../commons/commons.dart';
import '../repositories/repositories.dart';
import '../routes.dart';
import '../widgets/widgets.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileBloc>(
      create: (context) {
        final repository = RepositoryProvider.of<UserRepository>(context);

        return ProfileBloc(repository);
      },
      child: const SignInContent(),
    );
  }
}

class SignInContent extends StatefulWidget {
  const SignInContent({Key? key}) : super(key: key);

  @override
  State<SignInContent> createState() => _SignInContentState();
}

class _SignInContentState extends State<SignInContent> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: _onAuthListener,
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.fromLTRB(
              40.0,
              92.0,
              40.0,
              0.0,
            ),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Masuk",
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            color: ColorPalettes.black,
                            fontWeight: FontWeight.w700,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "Silahkan masukkan Email dan Kata Sandi untuk Masuk",
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: ColorPalettes.grayZill,
                            fontWeight: FontWeight.w400,
                          ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    TextField(
                      key: const Key(UIKeys.signInFormFieldEmail),
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Alamat Email',
                        hintStyle:
                            Theme.of(context).textTheme.caption?.copyWith(
                                  color: ColorPalettes.grayHint,
                                  fontWeight: FontWeight.w400,
                                ),
                        prefixIcon: const Icon(
                          Icons.mail_outline_rounded,
                          color: ColorPalettes.grayHint,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorPalettes.grayTextField,
                          ),
                        ),
                        focusColor: ColorPalettes.primary,
                        filled: true,
                        fillColor: ColorPalettes.grayTextField,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    TextField(
                      key: const Key(UIKeys.signInFormFieldPassword),
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Kata Sandi',
                        hintStyle:
                            Theme.of(context).textTheme.caption?.copyWith(
                                  color: ColorPalettes.grayHint,
                                  fontWeight: FontWeight.w400,
                                ),
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: ColorPalettes.grayHint,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            8.0,
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorPalettes.grayTextField,
                          ),
                        ),
                        focusColor: ColorPalettes.primary,
                        filled: true,
                        fillColor: ColorPalettes.grayTextField,
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      width: double.maxFinite,
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Lupa Kata Sandi?",
                          style: Theme.of(context).textTheme.caption?.copyWith(
                                color: ColorPalettes.primary,
                                fontWeight: FontWeight.w600,
                              ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 43.0,
                    ),
                    RoundedButton(
                      key: const Key(UIKeys.signInActionButton),
                      label: 'Masuk',
                      action: () => _onClickSignIn(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onClickSignIn(BuildContext context) {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ToastUtil.error(context, "Pastikan email dan password tidak kosong");
    } else {
      BlocProvider.of<ProfileBloc>(context).add(
        SignIn(),
      );
    }
  }

  void _onAuthListener(
    BuildContext context,
    ProfileState state,
  ) {
    if (state is SignInFailed) {
      // close progress dialog
      Navigator.of(context).pop();

      ToastUtil.error(context, "Gagal Sign In");
    } else if (state is SignInSuccess) {
      // close progress dialog
      Navigator.of(context).pop();

      Navigator.pushReplacementNamed(
        context,
        Routes.main,
      );
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => const TransparentLoadingDialog(
          key: Key(UIKeys.signInLoadingIndicator),
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
