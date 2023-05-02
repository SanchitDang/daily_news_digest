import 'dart:async';

import 'package:daily_news_digest/pages/home_screen.dart';
import 'package:daily_news_digest/pages/registration/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices{

  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user!=null) {
      Timer(const Duration(seconds: 3), () =>
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()))
      );
    } else{
      Timer(const Duration(seconds: 3), () =>
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => RegisterScreen()))
      );
    }

  }

}
