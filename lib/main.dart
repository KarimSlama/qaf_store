import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qaf_store/modules/splash_screen/splash_screen.dart';
import 'package:qaf_store/shared/cubit/cubit/home_cubit.dart';
import 'package:qaf_store/shared/cubit/cubit/login_cubit.dart';
import 'package:qaf_store/shared/cubit/cubit/search_cubit.dart';
import 'package:qaf_store/shared/cubit/states/login_states.dart';
import 'package:qaf_store/shared/data/cache_data/cache_helper.dart';
import 'package:qaf_store/styles/themes.dart';
import 'shared/components/constants.dart';
import 'shared/cubit/observer.dart';
import 'shared/data/network/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  token = CacheHelper.getData(key: 'token');
  print(token);
  runApp(const MyApp());
} //end main()

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StoreLoginCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoritesData()
            ..getProfileData(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: BlocConsumer<StoreLoginCubit, StoreLoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: const SplashScreen(),
          );
        },
      ),
    );
  } //end build()
} //end class
