import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qaf_store/layout/home_layout/home_layout.dart';
import 'package:qaf_store/modules/login_screen/login_screen.dart';
import 'package:qaf_store/shared/components/components.dart';
import 'package:qaf_store/shared/components/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

late Widget widget;

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNext().then((value) {
      navigateAndFinish(
        context,
        widget,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('2F3D64'),
      body: Container(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/background_logo.png',
                // fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/logo.png'),
                  const SizedBox(
                    height: 18.0,
                  ),
                  Text(
                    'All you want in one place',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: HexColor('FFDD00'),
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } //end build()

  Future navigateToNext() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    if (token != null) {
      widget = const HomeLayout();
    } else {
      widget = LoginScreen();
      print(token);
    }
  } //end navigateToNext()

} //end class
