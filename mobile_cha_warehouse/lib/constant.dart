import 'package:flutter/material.dart';

Map<int, Color> colorCodes = {
  50: const Color.fromRGBO(147, 205, 72, .1),
  100: const Color.fromRGBO(147, 205, 72, .2),
  200: const Color.fromRGBO(147, 205, 72, .3),
  300: const Color.fromRGBO(147, 205, 72, .4),
  400: const Color.fromRGBO(147, 205, 72, .5),
  500: const Color.fromRGBO(147, 205, 72, .6),
  600: const Color.fromRGBO(147, 205, 72, .7),
  700: const Color.fromRGBO(147, 205, 72, .8),
  800: const Color.fromRGBO(147, 205, 72, .9),
  900: const Color.fromRGBO(147, 205, 72, 1),
};

class Constants {
  static const Color mainColor = Color(0xff001D37);
  static const Color secondaryColor = Color(0xff00294D);
  static const MaterialColor materialMainColor =
      MaterialColor(0xff001D37, <int, Color>{
    50: Color(0xff001D37),
    100: Color(0xff001D37),
    200: Color(0xff001D37),
    300: Color(0xff001D37),
    400: Color(0xff001D37),
    500: Color(0xff001D37),
    600: Color(0xff001D37),
    700: Color(0xff001D37),
    800: Color(0xff001D37),
    900: Color(0xff001D37),
  });
  static const int minLengthUserName = 3;
  static const int minLengthPassWord = 6;
  static const Duration timeOutLimitation = Duration(seconds: 20);
  //static const String herokuServer =
  //    'https://hung-anh-storage-web-api.herokuapp.com';
  static const String herokuServer =
      'https://storagewebapi20210714122113.azurewebsites.net/';
  static const String localServer = 'http://192.168.1.13:8081';
  static String baseUrl = herokuServer;
  //static const baseUrl = 'http://192.168.1.13:8081';
}