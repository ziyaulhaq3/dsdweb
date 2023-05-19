import 'package:dsdweb/screens/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:dsdweb/screens/Dashboard.dart';
import 'package:dsdweb/auth/register.dart';
import 'package:dsdweb/routes/routes.dart';
import 'package:dsdweb/auth/signup.dart';

Future<void> main() async {
  //final token;
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    token: prefs.getString("token"),
  ));
}

class MyApp extends StatelessWidget {
  final token;
  const MyApp({
    @required this.token,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: MySplashScreen(token: token),
      home: (token != null && JwtDecoder.isExpired(token) == false)
          ? slideBar(token: token)
          : const signup(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routes: {
        Routes.signup: (context) => const signup(),
        Routes.register: (context) => const register(),
      },
    );
  }
}
