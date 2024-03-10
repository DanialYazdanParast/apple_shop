import 'dart:ui';

import 'package:apple_shop/bloc/basket/basket_bloc.dart';
import 'package:apple_shop/bloc/category/category_bloc.dart';
import 'package:apple_shop/bloc/home/home_bloc.dart';
import 'package:apple_shop/bloc/home/home_event.dart';
import 'package:apple_shop/constants/colors.dart';
import 'package:apple_shop/di/di.dart';

import 'package:apple_shop/screens/card_screen.dart';
import 'package:apple_shop/screens/category_screen.dart';
import 'package:apple_shop/screens/home_screen.dart';

import 'package:apple_shop/screens/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashborsScreen extends StatefulWidget {
  const DashborsScreen({super.key});

  @override
  State<DashborsScreen> createState() => _DashborsScreenState();
}

class _DashborsScreenState extends State<DashborsScreen> {
  int selectedbottomNavigationBar = 3;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: IndexedStack(
            index: selectedbottomNavigationBar,
            children: getScreens(),
          ),
          bottomNavigationBar: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: BottomNavigationBar(
                  onTap: (int index) {
                    setState(() {
                      selectedbottomNavigationBar = index;
                    });
                  },
                  currentIndex: selectedbottomNavigationBar,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedLabelStyle: const TextStyle(
                      fontFamily: 'SB', fontSize: 10, color: CustumColor.blue),
                  unselectedLabelStyle: const TextStyle(
                      fontFamily: 'SB', fontSize: 10, color: Colors.black),
                  items: [
                    BottomNavigationBarItem(
                      icon: Image.asset('assets/images/icon_profile.png'),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Container(
                            child: Image.asset(
                                'assets/images/icon_profile_active.png'),
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: CustumColor.blue,
                                  blurRadius: 20,
                                  spreadRadius: -7,
                                  offset: Offset(0, 13))
                            ])),
                      ),
                      label: 'حساب کاربری',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset('assets/images/icon_basket.png'),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Container(
                            child: Image.asset(
                                'assets/images/icon_basket_active.png'),
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: CustumColor.blue,
                                  blurRadius: 20,
                                  spreadRadius: -7,
                                  offset: Offset(0, 13))
                            ])),
                      ),
                      label: 'سبد خرسد',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset('assets/images/icon_category.png'),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Container(
                            child: Image.asset(
                                'assets/images/icon_category_active.png'),
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: CustumColor.blue,
                                  blurRadius: 20,
                                  spreadRadius: -7,
                                  offset: Offset(0, 13))
                            ])),
                      ),
                      label: 'دسته بندی',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset('assets/images/icon_home.png'),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Container(
                            child: Image.asset(
                                'assets/images/icon_home_active.png'),
                            decoration: const BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: CustumColor.blue,
                                  blurRadius: 20,
                                  spreadRadius: -7,
                                  offset: Offset(0, 13))
                            ])),
                      ),
                      label: 'خانه',
                    ),
                  ]),
            ),
          ),
        ));
  }
}

List<Widget> getScreens() {
  return <Widget>[
    const ProfileScreen(),
    BlocProvider(
      create: (context) {
        var bloc = locator.get<BasketBloc>();
        bloc.add(BasketFetchFromHiveEvent());
        return bloc;
      },
      child: CardScreen(),
    ),
    BlocProvider(create: (context) => CategoryBloc(), child: CategorryScreen()),
    Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider(
        create: (context) {
          var bloc = HomeBloc();
          bloc.add(HomeGetInitilzeData());
          return bloc;
        },
        child: HomeScreen(),
      ),
    ),
  ];
}
