import 'dart:convert';
import 'package:dsdweb/screens/orderData.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import '../config/config.dart';
import 'orders.dart';

class NewOrder extends StatefulWidget {
  final email;
  const NewOrder({@required this.email, Key? key});

  @override
  _NewOrderState createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  TextEditingController orderidController = TextEditingController();
  //TextEditingController dateController = TextEditingController();
  TextEditingController customernameController = TextEditingController();
  TextEditingController noController = TextEditingController();
  List? productList;
  @override
  void initState() {
    super.initState();
    getselectproddata();
  }

  void getselectproddata() async {
    var regBody = {};
    var response = await http.post(Uri.parse(getselectproduct),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    productList = jsonResponse['success'];
    print(productList);
    setState(() {
      productList = jsonResponse['success'];
    });
  }

  Future addNewOrder() async {
    if (orderidController.text.isNotEmpty &&
        customernameController.text.isNotEmpty) {
      var regbody = {
        "email": widget.email,
        "orderId": orderidController.text,
        "customerName": customernameController.text,
        "orderDetail": productList
      };
      var response = await http.post(Uri.parse(addnewOrder),
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

  Future deletedata() async {
    var regBody = {};
    var response = await http.post(Uri.parse(deleteSelectedproduct),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
    } else {
      print('something went wrong.');
    }
    //items = jsonResponse['success'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('New Order'),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Order Id",
            style: GoogleFonts.roboto(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.amber),
          ),
          TextField(
            controller: orderidController,
            decoration: InputDecoration(
                hintText: 'Order Id',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          /* SizedBox(height: 15),
          Container(
            child: TextField(
              controller: dateController,
              decoration: InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
          ), */
          SizedBox(height: 15),
          Text(
            "Customer Name",
            style: GoogleFonts.roboto(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.amber),
          ),
          TextField(
            controller: customernameController,
            decoration: InputDecoration(
                hintText: 'Customer Name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
          SizedBox(height: 20),
          Table(
            border: TableBorder.all(color: Colors.grey),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FlexColumnWidth(2.0),
              5: FlexColumnWidth(),
              6: FlexColumnWidth(2.0),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[200]),
                children: <Widget>[
                  Center(child: Text("No")),
                  Center(child: Text("Item")),
                  Center(child: Text("Ord\nQTY")),
                  Center(child: Text("UOM")),
                  Center(child: Text("Price")),
                  Center(child: Text("Disc")),
                  Center(child: Text("Amount\n(With Tax)")),
                ],
              ),
            ],
          ),
          Container(
            child: productList == null
                ? null
                : Table(
                    columnWidths: <int, TableColumnWidth>{
                      0: FlexColumnWidth(),
                      1: FlexColumnWidth(),
                      2: FlexColumnWidth(),
                      3: FlexColumnWidth(),
                      4: FlexColumnWidth(2.0),
                      5: FlexColumnWidth(),
                      6: FlexColumnWidth(2.0),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      for (var product in productList!)
                        TableRow(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Center(child: Text('1'))),
                            Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Center(
                                    child: Text('${product['barcode']}'))),
                            Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Center(
                                    child: Text('${product["quantity"]}'))),
                            Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Center(child: Text(product["uom"]))),
                            Padding(
                                padding: EdgeInsets.all(4.0),
                                child:
                                    Center(child: Text('${product["price"]}'))),
                            Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Center(
                                    child: Text("${product["discount"]}"))),
                            Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Center(
                                    child: Text("${product["amount"]}"))),
                          ],
                        ),
                    ],
                  ),
          ),
          SizedBox(height: 40),
          Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  child: Icon(Icons.add, color: Colors.white),
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => OrderForm()));
                  })),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("VAT"), Text("Total: ")],
          ),
          SizedBox(height: 120),
          Container(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed))
                    return Colors.purple.shade100;
                  return Theme.of(context).primaryColor;
                })),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  addNewOrder();
                  deletedata();
                  Navigator.pop(context);
                },
              )),
        ]),
      )),
    );
  }
}
