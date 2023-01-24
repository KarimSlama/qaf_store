import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qaf_store/modules/login_screen/login_screen.dart';
import 'package:qaf_store/shared/components/components.dart';
import 'package:qaf_store/shared/components/constants.dart';
import 'package:qaf_store/shared/cubit/cubit/login_cubit.dart';
import 'package:qaf_store/shared/cubit/states/login_states.dart';
import 'package:qaf_store/shared/data/cache_data/cache_helper.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    return BlocConsumer<StoreLoginCubit, StoreLoginStates>(
      listener: (context, state) {
        if (state is StoreLoginStateSuccess) {
          if (state.loginData.status!) {
            Fluttertoast.showToast(
              msg: state.loginData.message!,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              backgroundColor: Colors.cyan,
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb: 5,
              fontSize: 16.0,
            );
            CacheHelper.saveData(
              key: 'token',
              value: state.loginData.data!.token,
            ).then((value) {
              token = state.loginData.data!.token;
              navigateAndFinish(context, const LoginScreen());
            });
          } else {
            Fluttertoast.showToast(
              msg: state.loginData.message!,
              gravity: ToastGravity.BOTTOM,
              textColor: Colors.white,
              backgroundColor: Colors.red,
              toastLength: Toast.LENGTH_LONG,
              timeInSecForIosWeb: 5,
              fontSize: 16.0,
            );
          }
        }
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
                            'SIGN UP',
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
                                'already have an account',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateTo(context, LoginScreen());
                                },
                                child: Text(
                                  'LOGIN',
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
                            inputType: TextInputType.text,
                            controller: nameController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'name is required';
                              }
                              return null;
                            },
                            label: 'name',
                            prefixIcon: Icons.person_outline,
                          ),
                          const SizedBox(
                            height: 25.0,
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
                            inputType: TextInputType.phone,
                            controller: phoneController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'phone is required';
                              }
                              return null;
                            },
                            label: 'phone',
                            maxLength: 11,
                            prefixIcon: Icons.confirmation_number_outlined,
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          textForm(
                            inputType: TextInputType.visiblePassword,
                            controller: passwordController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'password is too short';
                              }
                              return null;
                            },
                            label: 'password',
                            prefixIcon: Icons.password_outlined,
                            isPassword:
                                StoreLoginCubit.getContext(context).isPassword,
                            suffixIcon:
                                StoreLoginCubit.getContext(context).suffix,
                            suffixPressed: () {
                              StoreLoginCubit.getContext(context)
                                  .changePasswordVisibility();
                            },
                          ),
                          const SizedBox(
                            height: 50.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! StoreLoginStateLoading,
                            builder: (context) => mainButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  StoreLoginCubit.getContext(context)
                                      .userRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              text: 'SIGN UP',
                              textColor: HexColor('2F3D64'),
                              color: HexColor('FFDD00'),
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          const SizedBox(
                            height: 20.0,
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
