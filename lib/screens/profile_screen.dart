import 'package:apple_shop/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop/bloc/authentication/auth_state.dart';
import 'package:apple_shop/screens/dashbord_screen.dart';
import 'package:apple_shop/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/colors.dart';

import '../util/auth_manager.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustumColor.backgroundScreenColor,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 24,
              left: 44,
              right: 44,
              bottom: 32,
            ),
            child: Container(
              height: 46,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Image.asset('assets/images/icon_apple_blue.png'),
                  const Expanded(
                    child: Text(
                      'حساب کاربری',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'SB',
                          fontSize: 16,
                          color: CustumColor.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                AuthManeger.logout();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
              child: Text('خروج')),
          const Text(
            'دانیال یزدان پرست',
            style: TextStyle(
              fontFamily: 'SB',
              fontSize: 16,
            ),
          ),
          const Text(
            '09174016011',
            style: TextStyle(
              fontFamily: 'SM',
              fontSize: 10,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Directionality(
            textDirection: TextDirection.rtl,
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                // CategorylItemChip(),
                // CategorylItemChip(),
                // CategorylItemChip(),
                // CategorylItemChip(),
                // CategorylItemChip(),
                // CategorylItemChip(),
                // CategorylItemChip(),
                // CategorylItemChip(),
                // CategorylItemChip(),
                // CategorylItemChip(),
                // CategorylItemChip(),
                // CategorylItemChip(),
                // CategorylItemChip(),
              ],
            ),
          ),
          const Spacer(),
          const Text(
            ' اپل شاپ',
            style: TextStyle(
                fontFamily: 'SM', fontSize: 10, color: CustumColor.gery),
          ),
          const Text(
            'v-1.0.00',
            style: TextStyle(
                fontFamily: 'SM', fontSize: 10, color: CustumColor.gery),
          ),
          const Text(
            'Instagram.com/Datiego',
            style: TextStyle(
                fontFamily: 'SM', fontSize: 10, color: CustumColor.gery),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      )),
    );
  }
}
