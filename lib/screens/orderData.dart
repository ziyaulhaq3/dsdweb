import 'dart:convert';

import 'package:dsdweb/config/config.dart';
import 'package:dsdweb/screens/newOrders.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class OrderData extends StatefulWidget {
  final email;
  const OrderData({@required this.email, super.key});

  @override
  State<OrderData> createState() => _OrderDataState();
}

class _OrderDataState extends State<OrderData> {
  List? Orderitems;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getnewOrderdata(widget.email);
  }

  void getnewOrderdata(email) async {
    var regBody = {"email": widget.email};
    var response = await http.post(Uri.parse(getnewOrderData),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    Orderitems = jsonResponse['success'];
    print(Orderitems);
    //it = prdoitems.length

    setState(() {
      Orderitems = jsonResponse['success'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text('Order'),
          backgroundColor: Colors.orange,
        ),
        body: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Orderitems == null
                    ? null
                    : ListView.builder(
                        itemCount: Orderitems!.length,
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
                                                'orderId - ${Orderitems![index]['orderId']}'),
                                            SizedBox(height: 10,),
                                            Text(
                                                'customerName - ${Orderitems![index]['customerName']}'),
                                            /*Text(
                                                'Price - ${Orderitems![index]['orderDetails']}'),*/
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }))),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, color: Colors.white),
            backgroundColor: Colors.amber,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewOrder(
                            email: widget.email,
                          )));
            }));
  }
}
