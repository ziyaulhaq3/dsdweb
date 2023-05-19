/*import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'Dashboard.dart';
import 'package:flutter/material.dart';

import '../routes/routes.dart';

class MySplashScreen extends StatefulWidget {
  final token;
  const MySplashScreen({@required this.token, Key? key});

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(milliseconds: 1500),
        
        );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("dsdsoftimg.png"),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "",
                style: TextStyle(
                  fontSize: 55,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/