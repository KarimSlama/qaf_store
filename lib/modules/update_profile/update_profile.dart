import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qaf_store/modules/profile_screen/profile_screen.dart';
import 'package:qaf_store/shared/components/components.dart';
import 'package:qaf_store/shared/components/constants.dart';
import 'package:qaf_store/shared/cubit/cubit/home_cubit.dart';
import 'package:qaf_store/shared/cubit/states/home_state.dart';
import 'package:qaf_store/shared/data/cache_data/cache_helper.dart';

class UpdateProfile extends StatelessWidget {
  UpdateProfile({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Profile',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Gabriola',
              fontSize: 24.0,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is UpdateUserDataSuccess) {
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
                navigateTo(context, const ProfileScreen());
              });
            }
          }
        },
        builder: (context, state) {
          var updateCubit = HomeCubit.getContext(context).userLoginData;
          nameController.text = updateCubit!.data!.name!;
          emailController.text = updateCubit.data!.email!;
          phoneController.text = updateCubit.data!.phone!;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textForm(
                      inputType: TextInputType.text,
                      controller: nameController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'name is required';
                        }
                        return null;
                      },
                      color: Colors.black,
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
                      color: Colors.black,
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
                      color: Colors.black,
                      maxLength: 11,
                      prefixIcon: Icons.confirmation_number_outlined,
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    ConditionalBuilder(
                      condition: state is! UpdateUserDataLoading,
                      builder: (context) => mainButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            HomeCubit.getContext(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        text: 'SAVE DATA',
                        textColor: HexColor('2F3D64'),
                        color: HexColor('FFDD00'),
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
