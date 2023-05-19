import 'dart:convert';
import 'package:dsdweb/screens/CustomerData.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../config/config.dart';

class CustomerForm extends StatefulWidget {
  final email;
  const CustomerForm({@required this.email, super.key});

  @override
  _CustomerFormState createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  TextEditingController customercodeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController streetnameController = TextEditingController();
  TextEditingController contactnoController = TextEditingController();
  TextEditingController vatnoController = TextEditingController();
  TextEditingController modeContoller = TextEditingController();
  TextEditingController creditlimitController = TextEditingController();

  //Map<String, dynamic> email = email;

  void saveCustomer() async {
    if (customercodeController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        streetnameController.text.isNotEmpty &&
        contactnoController.text.isNotEmpty &&
        vatnoController.text.isNotEmpty &&
        modeContoller.text.isNotEmpty &&
        creditlimitController.text.isNotEmpty) {
      var regbody = {
        "email": widget.email,
        "customerCode": customercodeController.text,
        "name": nameController.text,
        "street": streetnameController.text,
        "contactNo": contactnoController.text,
        "vatNo": vatnoController.text,
        "mode": modeContoller.text,
        "crdeitLimit": creditlimitController.text
      };
      var response = await http.post(Uri.parse(addCustomer),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regbody));

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (jsonResponse['status']) {
        //Navigator.push(context, MaterialPageRoute(builder: (c) => const signup()));
      } else {
        print("something went wrong");
      }
    }
    Fluttertoast.showToast(msg: 'Data Added Successfully');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.orangeAccent,
          title: Text('Customer Detail')),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          TextField(
            controller: customercodeController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: 'Customer Code',
                hintText: "exp: 001",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          SizedBox(height: 15),
          Container(
            child: TextField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  hintText: "zi",
                  labelText: 'Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          SizedBox(height: 15),
          Container(
            child: TextField(
              controller: streetnameController,
              decoration: InputDecoration(
                  labelText: 'Address',
                  hintText: "A1/454, Aray colony panvel",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          SizedBox(height: 15),
          Container(
            child: TextField(
              controller: contactnoController,
              decoration: InputDecoration(
                  labelText: 'Contact No',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          SizedBox(height: 15),
          Container(
            child: TextField(
              controller: vatnoController,
              decoration: InputDecoration(
                  labelText: 'Vat No',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          SizedBox(height: 15),
          Container(
            child: TextField(
              controller: modeContoller,
              decoration: InputDecoration(
                  labelText: 'Mode',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          SizedBox(height: 15),
          Container(
            child: TextField(
              controller: creditlimitController,
              decoration: InputDecoration(
                  labelText: 'Credit Limit',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          SizedBox(height: 10),
          Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed))
                    return Colors.purple.shade100;
                  return Colors.orangeAccent;
                })),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  saveCustomer();
                  Navigator.pop(context);
                },
              ))
        ]),
      )),
    );
  }
}
