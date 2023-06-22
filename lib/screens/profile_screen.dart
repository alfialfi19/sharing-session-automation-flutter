import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharing_session/blocs/blocs.dart';
import 'package:sharing_session/commons/commons.dart';
import 'package:sharing_session/repositories/repositories.dart';
import 'package:sharing_session/widgets/widgets.dart';

import '../routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (context) {
            final repository = RepositoryProvider.of<UserRepository>(context);

            return ProfileBloc(repository)
              ..add(
                LoadDetailProfile(),
              );
          },
        ),
      ],
      child: const ProfileContent(),
    );
  }
}

class ProfileContent extends StatelessWidget {
  const ProfileContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key(UIKeys.discoverProfileScreen),
      backgroundColor: ColorPalettes.backgroundLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile Screen",
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontSize: 18.0,
                color: ColorPalettes.dark,
                fontWeight: FontWeight.w700,
              ),
        ),
        backgroundColor: ColorPalettes.backgroundLight,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 20.0,
        ),
        child: ListView(
          children: [
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is DetailProfileError) {
                  return const SectionErrorState(
                    key: Key(UIKeys.profileContentErrorSection),
                  );
                }

                if (state is DetailProfileLoaded) {
                  var data = state.userData;

                  return Column(
                    key: const Key(UIKeys.profileContentLoadedSection),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Informasi Pribadi",
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: ColorPalettes.dark,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 20.0,
                        ),
                        child: const Divider(
                          color: ColorPalettes.line,
                        ),
                      ),
                      PersonalInformationItem(
                        label: "Nama",
                        value: data.name,
                      ),
                      PersonalInformationItem(
                        label: "Email",
                        value: data.email,
                      ),
                      PersonalInformationItem(
                        label: "Nomor Telepon",
                        value: data.phone,
                      ),
                      PersonalInformationItem(
                        label: "Alamat",
                        value:
                            "${data.address?.street}, ${data.address?.suite}, ${data.address?.city}, ${data.address?.zipcode}",
                      ),
                      const SizedBox(
                        height: 70.0,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        child: RoundedButton(
                          label: "Keluar",
                          labelColor: ColorPalettes.white,
                          backgroundColor: ColorPalettes.redConfirmation,
                          borderColor: ColorPalettes.redConfirmation,
                          action: () =>
                              Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.signIn,
                            (route) => false,
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return const SectionLoadingState(
                  key: Key(UIKeys.profileContentLoadingSection),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
