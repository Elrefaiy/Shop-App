import 'package:flutter/material.dart';
import 'package:flutter_applications/modules/login/login.dart';
import 'package:flutter_applications/shared/network/local/cache_helper.dart';

String token = '';

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

void logout(context){
  CacheHelper.removeData(key: 'token').then((value) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
  });
}