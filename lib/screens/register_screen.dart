import 'package:apple_shop/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop/bloc/authentication/auth_event.dart';
import 'package:apple_shop/bloc/authentication/auth_state.dart';
import 'package:apple_shop/screens/dashbord_screen.dart';
import 'package:apple_shop/screens/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _usernameTextContriller = TextEditingController();
  final _passwordTextContriller = TextEditingController();
  final _passwordConfirmTextContriller =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'ثبت نام در فروشگاه',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "SB",
                      fontSize: 34),
                ),
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'assets/images/icon_application.png',
                  width: 100,
                  height: 100,
                  color: Colors.indigoAccent,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('نام کاربری',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "SM",
                              fontSize: 18)),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.grey.shade300,
                        child: TextField(
                          controller: _usernameTextContriller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelStyle: TextStyle(
                                fontFamily: 'Sm',
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('رمز عبور',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "SM",
                              fontSize: 18)),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.grey.shade300,
                        child: TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _passwordTextContriller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelStyle: TextStyle(
                                fontFamily: 'Sm',
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('تکرار رمز عبور ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "SM",
                              fontSize: 18)),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Colors.grey.shade300,
                        child: TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _passwordConfirmTextContriller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelStyle: TextStyle(
                                fontFamily: 'Sm',
                                fontSize: 18,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    //logic
                    //tost
                    //snac
                    //navigat
                    if (state is AuthResponseState) {
                      state.response.fold((l) {}, (r) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const DashborsScreen(),
                        ));
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthInitiateState) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigoAccent,
                            textStyle:
                                const TextStyle(fontFamily: 'SB', fontSize: 18),
                            minimumSize: const Size(200, 48),
                          ),
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context).add(
                                AuthRegisterRequest(
                                    _usernameTextContriller.text,
                                    _passwordTextContriller.text,
                                    _passwordConfirmTextContriller.text));
                          },
                          child: const Text('ثبت نام'));
                    } else if (State is AuthLodingState) {
                      return const CircularProgressIndicator();
                    } else if (state is AuthResponseState) {
                      Text widget = const Text('');
                      state.response.fold((l) {
                        widget = Text(l);
                      }, (r) {
                        widget = Text(r);
                      });
                      return widget;
                    }

                    return const Text('');
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ));
                    },
                    child: const Text(
                      ' اگر حساب کاربری دارید وارد شوید',
                      style: const TextStyle(fontFamily: 'SB', fontSize: 16),
                    )),
                const SizedBox(
                  height: 20,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
