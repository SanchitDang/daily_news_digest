import 'package:daily_news_digest/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final color = const Color(0xffFE0000);

  SplashServices sS = SplashServices();
  double screenWidth = 0;

  @override
  void initState(){
    super.initState();
    sS.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Text("DailyNews\nDigest",style: GoogleFonts.montserrat(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: screenWidth / 8,
        ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
