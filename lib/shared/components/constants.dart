import 'package:hexcolor/hexcolor.dart';
import 'package:qaf_store/modules/login_screen/login_screen.dart';
import 'package:qaf_store/shared/components/components.dart';
import 'package:qaf_store/shared/data/cache_data/cache_helper.dart';

var mainColor = HexColor('2F3D64');

void logOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    navigateAndFinish(context, LoginScreen());
  });
}

String? token = '';
