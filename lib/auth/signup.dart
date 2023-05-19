import 'package:dsdweb/auth/register.dart';
import 'package:dsdweb/screens/sidebar.dart';
//import 'package:dsdweb/screens/screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import '../config/config.dart';
import 'dart:convert';

import '../screens/Dashboard.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;
  late SharedPreferences prefers;

  @override
  void initState() {
    super.initState();
    initSharedpref();
  }

  void initSharedpref() async {
    prefers = await SharedPreferences.getInstance();
  }

  void loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var reqbody = {
        "email": emailController.text,
        "password": passwordController.text
      };
      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqbody));
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (jsonResponse["status"]) {
        var myToken = jsonResponse["token"];
        prefers.setString('token', myToken);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => slideBar(
                      token: myToken,
                    )));
      } else {
        print("something went wrong.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 600,
          width: 600,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: ListView(
                  children: <Widget>[
                    /*Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'DsdSoft',
                          style: TextStyle(
                            color: Colors.amber,
                              fontWeight: FontWeight.w500,
                              fontSize: 50),
                        )),
                    Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          'Log in',
                          style: TextStyle(fontSize: 20),
                        )),*/
                    SizedBox(
                      height: 300,
                        child: Align(
                          alignment: Alignment.center,
                          child: Image.asset("assets/dsdsoftlogo.png"),
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'User email',
                          errorStyle: const TextStyle(color: Colors.black),
                          errorText: _isNotValidate ? "enter proper info" : null,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Password',
                          errorStyle: const TextStyle(color: Colors.black),
                          errorText: _isNotValidate ? "enter proper info" : null,
                        ),
                      ),
                    ),const SizedBox(height: 50,),
                    Container(
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: ElevatedButton(
                          child: Text('Login', style: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.w500),),
                          onPressed: () {
                            loginUser(); //login function call from top.
                          },
                        )),
                    Row(
                      children: <Widget>[
                        Text('Does not have account?', style:GoogleFonts.roboto(
                          fontSize: 15, fontWeight: FontWeight.w500)),
                        TextButton(
                          child: Text(
                            'Register',
                            style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (c) => const register()));
                            //signup screen
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
    
  }
}
