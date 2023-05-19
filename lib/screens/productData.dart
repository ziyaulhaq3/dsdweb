import 'dart:convert';
import 'package:dsdweb/screens/productForm.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../config/config.dart';

class ProductData extends StatefulWidget {
  final email;
  const ProductData({@required this.email, super.key});

  @override
  State<ProductData> createState() => _ProductDataState();
}

class _ProductDataState extends State<ProductData> {
  List? Pitems;
  late String email = widget.email;
  @override
  void initState() {
    super.initState();
    email = widget.email;
    getproductData(widget.email);
  }
    void getproductData(email) async {
    var regBody = {"email": widget.email};
    var response = await http.post(Uri.parse(getProductdata),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    Pitems = jsonResponse['success'];
    print(Pitems);
    //it = prdoitems.length

    setState(() {
      Pitems = jsonResponse['success'];
    });
  }

  /* void getproductData(email) async {
    var regBody = {"email": widget.email};
    var request = http.Request(
      'GET',
      Uri.parse(getProductdata),
    )..headers.addAll({"Content-Type": "application/json"});
    request.body = jsonEncode(regBody);

    http.StreamedResponse response = await request.send();

    //print(response.statusCode);
    var res = jsonDecode(await response.stream.bytesToString());
    Pitems = res["success"];
    print(Pitems);

    setState(() {});
  }
 */
  void deleteproductdata(id) async {
    print(id);
    var regBody = {"_id": id};
    var response = await http.post(Uri.parse(deleteProductdata),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']){  
      getproductData(email);
    }
    //items = jsonResponse['success'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text('Product'),
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
                child: Pitems == null
                    ? null
                    : ListView.builder(
                        itemCount: Pitems!.length,
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
                                                'barcode - ${Pitems![index]['barcode']}'),
                                            Text(
                                                'Product Name - ${Pitems![index]['productName']}'),
                                            Text(
                                                'Price - ${Pitems![index]['productPrice']}'),
                                          ]),
                                       Column(
                                         children: [
                                           Text('stock'),
                                           Text("${Pitems![index]['stock']}"),
                                         ],
                                       ),   
                                      IconButton(
                                        alignment: Alignment.bottomRight,
                                        onPressed: () {
                                          //action coe when button is pressed
                                          //print('${items![index]['_id']}');
                                          deleteproductdata(
                                              '${Pitems![index]['_id']}');
                                        },
                                        icon: Icon(Icons.delete),
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
            backgroundColor: Colors.amber,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => productForm(
                            email: widget.email,
                          )));
            }));
  }
}
