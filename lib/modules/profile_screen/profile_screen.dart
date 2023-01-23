import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qaf_store/modules/update_profile/update_profile.dart';
import 'package:qaf_store/shared/components/components.dart';
import 'package:qaf_store/shared/components/constants.dart';
import 'package:qaf_store/shared/cubit/cubit/home_cubit.dart';
import 'package:qaf_store/shared/cubit/states/home_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (context, state) {
        var profileCubit = HomeCubit.getContext(context);
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: [
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadiusDirectional.all(
                      Radius.circular(100.0),
                    ),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 370.0,
                    decoration: BoxDecoration(
                      color: HexColor('2F3D64').withOpacity(.2),
                      borderRadius: BorderRadiusDirectional.circular(
                        20.0,
                      ),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Container(
                          alignment: AlignmentDirectional.topEnd,
                          child: IconButton(
                            alignment: AlignmentDirectional.topEnd,
                            onPressed: () {
                              navigateTo(
                                context,
                                UpdateProfile(),
                              );
                            },
                            icon: const Icon(
                              Icons.mode_edit_outline_outlined,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'ID:',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '${profileCubit.userLoginData!.data!.id!.round()}',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 22.0,
                              ),
                            ),
                            const Text(
                              'Name:',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              profileCubit.userLoginData!.data!.name!,
                              style: const TextStyle(
                                fontSize: 22.0,
                                color: Colors.grey,
                              ),
                            ),
                            const Text(
                              'Email:',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              profileCubit.userLoginData!.data!.email!,
                              style: const TextStyle(
                                fontSize: 22.0,
                                color: Colors.grey,
                              ),
                            ),
                            const Text(
                              'Phone:',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              profileCubit.userLoginData!.data!.phone!,
                              style: const TextStyle(
                                fontSize: 22.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                mainButton(
                  onPressed: () {
                    logOut(context);
                  },
                  text: 'LOGOUT',
                  isUpper: true,
                  color: HexColor('2F3D64'),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
