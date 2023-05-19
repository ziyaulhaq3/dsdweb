import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'paymentData.dart';
import 'package:dsdweb/config/config.dart';

class PaymentForm extends StatefulWidget {
  final email;
  const PaymentForm({@required this.email, super.key});

  @override
  State<PaymentForm> createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  TextEditingController paymentIdController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  String date = "";
  DateTime selectedDate = DateTime.now();

  void paymentdatatomongo() async {
    if (paymentIdController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        customerNameController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        balanceController.text.isNotEmpty &&
        totalAmountController.text.isNotEmpty) {
      var regbody = {
        "email": widget.email,
        "paymentId": paymentIdController.text,
        "date": dateController.text,
        "customerName": customerNameController.text,
        "amount": amountController.text,
        "balance": balanceController.text,
        "totalAmount": totalAmountController.text
      };
      var response = await http.post(Uri.parse(addPayment),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regbody));

      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if (jsonResponse['status']) {
        //Navigator.push(context, MaterialPageRoute(builder: (c) =>
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
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        title: Text("ADD PAYMENT"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Monsterrat-Regular',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 40, 10),
                  child: Text(
                    //widget.email,
                    "Payment Id",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monsterrat-Regular',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: SizedBox(
                    height: 50,
                    width: 330,
                    child: TextField(
                      controller: paymentIdController,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Monsterrat-Medium',
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 40, 10),
                  child: Text(
                    "Date",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monsterrat-Regular',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: SizedBox(
                    height: 50,
                    width: 330,
                    child: TextField(
                      controller: dateController,
                      keyboardType: TextInputType.datetime,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Monsterrat-Medium',
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 40, 10),
                  child: Text(
                    "Customer Name",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monsterrat-Regular',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: SizedBox(
                    height: 50,
                    width: 330,
                    child: TextField(
                      controller: customerNameController,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Monsterrat-Medium',
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(30, 10, 20, 10),
                            child: Text(
                              "Amount",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Monsterrat-Regular',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: SizedBox(
                              height: 50,
                              width: 140,
                              child: TextField(
                                controller: amountController,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'Monsterrat-Medium',
                                  fontSize: 18,
                                ),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 40, 10),
                            child: Text(
                              "Balance",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Monsterrat-Regular',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: SizedBox(
                              height: 50,
                              width: 150,
                              child: TextField(
                                controller: balanceController,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontFamily: 'Monsterrat-Medium',
                                  fontSize: 18,
                                ),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        amountController.clear();
                        paymentIdController.clear();
                        balanceController.clear();
                        customerNameController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                      child: const Text(
                        "CLEAR",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          wordSpacing: 3,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: SizedBox(
                    height: 50,
                    width: 330,
                    child: TextFormField(
                      controller: totalAmountController,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontFamily: 'Monsterrat-Medium',
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 50,
                  width: 350,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                    child: ElevatedButton(
                      onPressed: () async {
                        paymentdatatomongo();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                      child: const Text(
                        "SAVE",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          wordSpacing: 3,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/**
 * actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_vert_rounded))
        ],
 */

/*
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          //validateForm();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )),
                        child: const Text(
                          "CLEAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            wordSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                   */

/*DataTable(
                        border: TableBorder(
                          horizontalInside: BorderSide(color: Colors.black),
                          verticalInside: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          bottom: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                        ),
                        columns: [
                          DataColumn(label: Text("Name")),
                          DataColumn(label: Text("Birthday")),
                          DataColumn(label: Text("Email id")),
                          DataColumn(label: Text("Delete")),
                        ], rows: DataRow[],),
                */
/*
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Table(
                      defaultColumnWidth: FixedColumnWidth(120.0),
                      border: TableBorder.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 2),
                      children: [
                        TableRow(children: [
                          Column(children: [
                            Text('Website', style: TextStyle(fontSize: 20.0))
                          ]),
                          Column(children: [
                            Text('Tutorial', style: TextStyle(fontSize: 20.0))
                          ]),
                          Column(children: [
                            Text('Review', style: TextStyle(fontSize: 20.0))
                          ]),
                        ]),
                        TableRow(children: [
                          Column(children: []),
                          Column(children: []),
                          Column(children: []),
                        ]),
                        TableRow(children: [
                          Column(children: []),
                          Column(children: []),
                          Column(children: []),
                        ]),
                        TableRow(children: [
                          Column(children: []),
                          Column(children: []),
                          Column(children: []),
                        ]),
                      ],
                    ),
                  ),
                  */

/*SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Total Amount:",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monsterrat-Regular',
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 320,
                    child: Row(children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            //validateForm();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          child: const Text(
                            "SAVE",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              wordSpacing: 3,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            //validateForm();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                          child: const Text(
                            "CANCEL",
                            style: TextStyle(
                              color: Colors.orange,
                              fontSize: 18,
                              wordSpacing: 3,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),*/
