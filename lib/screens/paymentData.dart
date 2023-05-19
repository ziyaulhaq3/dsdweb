import 'dart:convert';
import 'package:dsdweb/screens/paymentform.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../config/config.dart';

class paymentData extends StatefulWidget {
  final email;
  const paymentData({@required this.email, super.key});

  @override
  State<paymentData> createState() => _paymentDataState();
}

class _paymentDataState extends State<paymentData> {
  List? payitems;
  late String email = widget.email;
  @override
  void initState() {
    super.initState();
    email = widget.email;
    getpaymentData(widget.email);
  }
   void getpaymentData(email) async {
    var regBody = {"email": widget.email};
    var response = await http.post(Uri.parse(getPaymentdata),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    payitems = jsonResponse['success'];
    print(payitems);
    //it = prdoitems.length

    setState(() {
      payitems = jsonResponse['success'];
    });
  }
  /* void getpaymentData(email) async {
    var regBody = {"email": widget.email};
    var request = http.Request(
      'GET',
      Uri.parse(getPaymentdata),
    )..headers.addAll({"Content-Type": "application/json"});
    request.body = jsonEncode(regBody);

    http.StreamedResponse response = await request.send();

    //print(response.statusCode);
    var res = jsonDecode(await response.stream.bytesToString());
    items = res["success"];
    print(items);

    setState(() {});
  }
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("paymentData"),
        titleTextStyle: TextStyle(
          //backgroundColor: Colors.orange,
          
        fontWeight: FontWeight.bold,
        fontSize: 20,
        ),
      ),*/
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text('PAYMENTS'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Monsterrat-Regular',
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: payitems == null
                  ? null
                  : ListView.builder(
                      itemCount: payitems!.length,
                      itemBuilder: (context, int index) {
                        return Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          //borderOnForeground: false,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Card(
                              shadowColor: Colors.grey,
                              color: Colors.grey[100],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'paymentId - ${payitems![index]['paymentId']}'),
                                          Text(
                                              'customerName - ${payitems![index]['customerName']}'),
                                          Text(
                                              'balance - ${payitems![index]['balance']}')
                                        ]),
                                        Text("status - ",),
                                    IconButton(
                                      alignment: Alignment.bottomRight,
                                      onPressed: () {
                                        //action coe when button is pressed
                                      },
                                      icon: Icon(Icons.edit_note),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }))),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.orange,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PaymentForm(
                          email: widget.email,
                        )));
          }),
    );
  }
}
