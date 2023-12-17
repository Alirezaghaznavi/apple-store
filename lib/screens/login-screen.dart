import 'package:apple_store/bloc/authentication/auth_bloc.dart';
import 'package:apple_store/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var _usernameTextController =
        TextEditingController(text: 'alirezaghaznavi');
    final _passTextController = TextEditingController(text: 'aliali2020');

    return Scaffold(
      backgroundColor: CustomColors.blue,
      body: BlocProvider(
        create: (context) => AuthBloc(),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icon_application.png',
                      width: 190,
                      height: 190,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'اپل استور',
                      style: TextStyle(
                        fontFamily: 'SB',
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _usernameTextController,
                        decoration: InputDecoration(
                          counterStyle: TextStyle(
                            fontFamily: 'SM',
                            fontSize: 15,
                          ),
                          label: Text(' نام کاربری '),
                          labelStyle: TextStyle(
                            fontSize: 15,
                            fontFamily: 'SM',
                            color: Colors.black.withOpacity(0.7),
                          ),
                          floatingLabelStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: 'SM',
                            color: Colors.black,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: CustomColors.gery,
                              width: 1.8,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: _passTextController,
                        scribbleEnabled: false,
                        style: TextStyle(),
                        decoration: InputDecoration(
                          label: Text(' رمز عبور '),
                          labelStyle: TextStyle(
                            fontSize: 15,
                            fontFamily: 'SM',
                            color: Colors.black.withOpacity(0.7),
                          ),
                          floatingLabelStyle: TextStyle(
                            fontSize: 16,
                            fontFamily: 'SM',
                            color: Colors.black,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: CustomColors.gery,
                              width: 1.8,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthInitialState) {
                            return ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<AuthBloc>(context).add(
                                  AuthLogingRequest(
                                      _usernameTextController.text,
                                      _passTextController.text),
                                );
                              },
                              child: Text(
                                'ورود به حساب کاربری',
                                style: TextStyle(
                                  fontFamily: 'SB',
                                  fontSize: 20,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          }
                          if (state is AuthLoadingState) {
                            return CircularProgressIndicator();
                          }
                          if (state is AuthResponseState) {
                            Text widget = Text('');
                            state.response.fold(
                              (r) => widget = Text(r),
                              (l) => widget = Text(l),
                            );
                            return widget;
                          }
                          return Text('خطای نامشخص');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
