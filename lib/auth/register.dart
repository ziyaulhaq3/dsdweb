import 'dart:convert';

import 'package:dsdweb/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import '../config/config.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isNotValidate = false;

  void registerUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      var regbody = {
        "email": emailController.text,
        "password": passwordController.text
      };
      var response = await http.post(Uri.parse(registration),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regbody));

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (jsonResponse['status']) {
          Navigator.push(context,
                          MaterialPageRoute(builder: (c) => const signup()));        
      } else {
        print("something went wrong");
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
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
            child:Card(
              //padding: const EdgeInsets.all(10),
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
                            fontSize: 30),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: const Text(
                        'register',
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
                        filled: true,
                        errorStyle: TextStyle(color: Colors.black),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        errorStyle: TextStyle(color: Colors.black),
                        errorText: _isNotValidate ? "Enter Proper Info" : null,
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child:  Text('Register',style: GoogleFonts.roboto(
                        fontSize: 20, fontWeight: FontWeight.w500)),
                        onPressed: () {
                          registerUser();
                        },
                      )),
                  Row(
                    children: <Widget>[
                       Text('Have account?',style: GoogleFonts.roboto(
                        fontSize: 15, fontWeight: FontWeight.w500)),
                      TextButton(
                        child:  Text(
                          'Login',
                          style: GoogleFonts.roboto(
                        fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (c) => const signup()));
                          //signup screen
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              )),),
        ),
      ),
    );
    
  }
}
