import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sharing_session/commons/commons.dart';

import '../blocs/blocs.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

const screenHome = 0;
const screenProduct = 1;
const screenProfile = 2;

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainBloc>(
          create: (context) {
            return MainBloc();
          },
        ),
      ],
      child: const MainContent(),
    );
  }
}

class MainContent extends StatefulWidget {
  const MainContent({Key? key}) : super(key: key);

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  List<Widget> _pages = <Widget>[];

  @override
  void initState() {
    _pages = <Widget>[
      const HomeScreen(),
      const ProductScreen(),
      const ProfileScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: MyNavigationBar(
            key: const Key(UIKeys.discoverMainTab),
            currentIndex: state.currentIndex,
            onChange: _onChangePage,
            children: [
              NavigationBarItem(
                navItemKey: const Key(UIKeys.discoverHomeTabActive),
                label: "Home",
                iconUrl: ResourceIcons.homeInactive,
                onSelectedIconUrl: ResourceIcons.homeActive,
              ),
              NavigationBarItem(
                navItemKey: const Key(UIKeys.discoverProductTabActive),
                label: "Product",
                iconUrl: ResourceIcons.productInactive,
                onSelectedIconUrl: ResourceIcons.productActive,
              ),
              NavigationBarItem(
                navItemKey: const Key(UIKeys.discoverProfileTabActive),
                label: "Profile",
                iconUrl: ResourceIcons.profileInactive,
                onSelectedIconUrl: ResourceIcons.profileActive,
              ),
            ],
          ),
          body: WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: _pages[state.currentIndex],
          ),
        );
      },
    );
  }

  void _onChangePage(int index) {
    BlocProvider.of<MainBloc>(context).add(MainScreenChange(
      index: index,
    ));
  }
}
