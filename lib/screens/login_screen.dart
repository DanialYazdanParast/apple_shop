import 'package:apple_shop/bloc/authentication/auth_bloc.dart';
import 'package:apple_shop/bloc/authentication/auth_event.dart';
import 'package:apple_shop/bloc/authentication/auth_state.dart';
import 'package:apple_shop/main.dart';
import 'package:apple_shop/screens/dashbord_screen.dart';
import 'package:apple_shop/screens/register_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _usernameTextContriller = TextEditingController();
  final _passwordTextContriller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: ViewContamer(
          usernameTextContriller: _usernameTextContriller,
          passwordTextContriller: _passwordTextContriller),
    );
  }
}

class ViewContamer extends StatelessWidget {
  const ViewContamer({
    super.key,
    required TextEditingController usernameTextContriller,
    required TextEditingController passwordTextContriller,
  })  : _usernameTextContriller = usernameTextContriller,
        _passwordTextContriller = passwordTextContriller;

  final TextEditingController _usernameTextContriller;
  final TextEditingController _passwordTextContriller;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const Text(
                    'ورود به فروشگاه',
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
                    height: 20,
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
                          height: 20,
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      //logic
                      //tost
                      //snac
                      //navigat
                      if (state is AuthResponseState) {
                        state.response.fold((l) {
                          _usernameTextContriller.text = '';
                          _passwordTextContriller.text = '';
                          var snackBar = SnackBar(
                              backgroundColor: Colors.black,
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                l,
                                style:
                                    TextStyle(fontFamily: 'SM', fontSize: 14),
                              ));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }, (r) {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => DashborsScreen(),
                          ));
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthInitiateState) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigoAccent,
                              textStyle: const TextStyle(
                                  fontFamily: 'SB', fontSize: 20),
                              minimumSize: const Size(200, 48),
                            ),
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context).add(
                                  AuthLoginRequest(_usernameTextContriller.text,
                                      _passwordTextContriller.text));
                            },
                            child: const Text('ورود به حساب کاربری'));
                      }
                      if (State is AuthLodingState) {
                        return const CircularProgressIndicator();
                      }
                      if (state is AuthResponseState) {
                        Widget widget = const Text('');
                        state.response.fold((l) {
                          widget = ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigoAccent,
                                textStyle: const TextStyle(
                                    fontFamily: 'SB', fontSize: 20),
                                minimumSize: const Size(200, 48),
                              ),
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context).add(
                                    AuthLoginRequest(
                                        _usernameTextContriller.text,
                                        _passwordTextContriller.text));
                              },
                              child: const Text('ورود به حساب کاربری'));
                        }, (r) {
                          widget = Text(r);
                        });
                        return widget;
                      }

                      return const Text('');
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return RegisterScreen();
                          },
                        ));
                      },
                      child: const Text(
                        ' اگر حساب کاربری ندارید ثبت نام کنید',
                        style: const TextStyle(fontFamily: 'SB', fontSize: 16),
                      )),
                ],
              ),
            ),
          )),
    );
  }
}
