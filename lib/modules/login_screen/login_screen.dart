import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qaf_store/layout/home_layout/home_layout.dart';
import 'package:qaf_store/modules/sign_up_screen/sign_up_screen.dart';
import 'package:qaf_store/shared/components/components.dart';
import 'package:qaf_store/shared/components/constants.dart';
import 'package:qaf_store/shared/cubit/cubit/login_cubit.dart';
import 'package:qaf_store/shared/cubit/states/login_states.dart';
import 'package:qaf_store/shared/data/cache_data/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreLoginCubit, StoreLoginStates>(
      listener: (context, state) {
        if (state is StoreLoginStateSuccess) {
          if (state.loginData.status!) {
            showToast(
              state: ToastBackgroundColor.SUCCESS,
              toastText: state.loginData.message!,
            );
            CacheHelper.saveData(
              key: 'token',
              value: state.loginData.data!.token,
            ).then((value) {
              token = state.loginData.data!.token;
              print('success saved $value');
              navigateAndFinish(context, const HomeLayout());
            });
          } else {
            showToast(
              toastText: state.loginData.message!,
              state: ToastBackgroundColor.ERROR,
            );
          } //end else
        } //end if()
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: HexColor('2F3D64'),
          body: Center(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/background_logo.png',
                      // fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'if you don\'t have any account',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, SignUpScreen());
                                },
                                child: Text(
                                  'SIGN UP',
                                  style: TextStyle(
                                    color: HexColor('FFDD00'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          textForm(
                            inputType: TextInputType.emailAddress,
                            controller: emailController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'email is required';
                              }
                              return null;
                            },
                            label: 'email address',
                            prefixIcon: Icons.mark_email_read_outlined,
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          textForm(
                              inputType: TextInputType.visiblePassword,
                              controller: passwordController,
                              isPassword: StoreLoginCubit.getContext(context)
                                  .isPassword,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'password is too short';
                                }
                                return null;
                              },
                              label: 'password',
                              prefixIcon: Icons.password_outlined,
                              suffixIcon:
                                  StoreLoginCubit.getContext(context).suffix,
                              suffixPressed: () {
                                StoreLoginCubit.getContext(context)
                                    .changePasswordVisibility();
                              },
                              onSubmit: (value) {
                                if (formKey.currentState!.validate()) {
                                  StoreLoginCubit.getContext(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                } //end if()
                              } //end onSubmit()
                              ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            'forgot the password',
                            style: TextStyle(
                              fontSize: 16.0,
                              decoration: TextDecoration.underline,
                              color: Color(0XFFFFDD00),
                              fontFamily: 'Cairo',
                            ),
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! StoreLoginStateLoading,
                            builder: (context) => mainButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  StoreLoginCubit.getContext(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                } //end if()
                              },
                              text: 'LOGIN',
                              textColor: HexColor('2F3D64'),
                              color: HexColor('FFDD00'),
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.only(
                                start: 20.0, end: 20.0),
                            height: 1,
                            width: double.infinity,
                            color: Colors.white24,
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            'or continue login with',
                            style: TextStyle(
                              color: Color(0XFFFFDD00),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                backgroundColor: Color(
                                  (0XFF2F3D64),
                                ),
                                backgroundImage:
                                    AssetImage('assets/images/google.png'),
                                radius: 25.0,
                              ),
                              SizedBox(
                                width: 40.0,
                              ),
                              CircleAvatar(
                                backgroundColor: Color(
                                  (0XFF2F3D64),
                                ),
                                backgroundImage:
                                    AssetImage('assets/images/facebook.png'),
                                radius: 25.0,
                              ),
                              SizedBox(
                                width: 40.0,
                              ),
                              CircleAvatar(
                                backgroundColor: Color(
                                  (0XFF2F3D64),
                                ),
                                backgroundImage:
                                    AssetImage('assets/images/twitter.png'),
                                radius: 25.0,
                              ),
                            ],
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
      },
    );
  } //end build()
} //end class
