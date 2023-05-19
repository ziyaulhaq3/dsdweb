import 'dart:convert';
//import 'package:dropdownfield/dropdownfield.dart';
//import 'package:flutter/foundation.dart';
import 'package:dsdweb/screens/newOrders.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/config.dart';


class OrderForm extends StatefulWidget {
  const OrderForm({super.key});

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  List? Proditems;
  List? prod;
  String? selectedvalue;

  TextEditingController barcodeController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController uomController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  int? res = 0, r1 = 0, num1 = 0, num2 = 0, num3 = 0, r2 = 0;
  totalprice() {
    setState(() {
      num1 = int.parse(quantityController.text);
      num2 = int.parse(priceController.text);
      r1 = num1! * num2!;
      num3 = int.parse(discountController.text);
      r2 = r1! * num3! ~/ 100;
      res = r1! - r2!;
    });
  }

  @override
  void initState() {
    super.initState();
    //email = widget.email;
    getProductdatabar();
    //totalprice();
  }
  void saveselectProduct() async {
    if (barcodeController.text.isNotEmpty 
    && stockController.text.isNotEmpty
    && quantityController.text.isNotEmpty
    && uomController.text.isNotEmpty
    && amountController.text.isNotEmpty
    && priceController.text.isNotEmpty
    && discountController.text.isNotEmpty) {
      var regbody = {
        "barcode":barcodeController.text,
        "stock":stockController.text,
        "quantity":quantityController.text,
        "uom":uomController.text,
        "price":priceController.text,
        "discount":discountController.text,
        "amount":amountController.text
      };
      var response = await http.post(Uri.parse(selectproduct),
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

  void getProductdatabar() async {
    var regBody = {};
    var response = await http.post(Uri.parse(getproductdatabar),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    Proditems = jsonResponse['success'];
    print(Proditems);
    //it = prdoitems.length

    setState(() {
      Proditems = jsonResponse['success'];
    });
  }

  Future getProductdataInfeilds(String? selectedvalue) async {
    var reBody = {"productName": selectedvalue};
    //print(selectedvalue);
    var res = await http.post(Uri.parse(getproductdataname),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reBody));
    var jResponse = jsonDecode(res.body);
    prod = jResponse['success'];
    print(prod);
    var p = prod?[0]['barcode'];
    print(p);

    //var bar = prod?.indexWhere((element) => false)['barcode'];
    //barcode = prod['']

    setState(() {
      //prod = jsonResponse['success'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(foregroundColor: Colors.white, title: Text('select product')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Item Name",
                style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.amber),
              ),
              SizedBox(height: 15),
              DropdownButton(
                  isExpanded: true,
                  hint: Text("select product"),
                  value: selectedvalue,
                  items: Proditems?.map((category) {
                    return DropdownMenuItem(
                        value: category["productName"],
                        child: Text(
                          category['productName'],
                        ));
                  }).toList(),
                  onChanged: (value) {
                    //stockController.text = prod?[0]['productName'] as String;
                    setState(() {
                      selectedvalue = value as String?;
                      barcodeController.text = '${prod?[0]['barcode']}';

                      stockController.text = '${prod?[0]['stock']}';
                      priceController.text = '${prod?[0]['productPrice']}';
                    });
                    print(selectedvalue);
                    var it = getProductdataInfeilds(selectedvalue);
                    print(it);

                    //var bar = Text(it['productPrice'];);
                    //print(it['barcode']);

                    print(prod);
                  }),
              Text(
                "barcode",
                style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.amber),
              ),
              //Text('${prod?[0]['barcode']}'),
              Container(
                child: TextField(
                  controller: barcodeController,
                  decoration: InputDecoration(
                      hintText: 'barcode',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "stock",
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.amber),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        child: TextField(
                          controller: stockController,
                          decoration: InputDecoration(
                              hintText: 'stock',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quantity",
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.amber),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        child: TextField(
                          controller: quantityController,
                          decoration: InputDecoration(
                              hintText: 'Quatity',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "uom",
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.amber),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        child: TextField(
                          controller: uomController,
                          decoration: InputDecoration(
                              hintText: 'uom',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price",
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.amber),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        child: TextField(
                          controller: priceController,
                          decoration: InputDecoration(
                              hintText: 'Price',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Discount",
                style: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.w500,color: Colors.amber),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: TextField(
                  controller: discountController,
                  decoration: InputDecoration(
                      hintText: 'Discount',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Amount",
                style: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.w500,color: Colors.amber),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: TextField(
                  controller: amountController,
                  onTap: () {
                    setState(() {
                      totalprice();
                      amountController.text = "$res";
                    });
                  },
                  decoration: InputDecoration(
                      hintText: 'Total amount',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
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
                      return Theme.of(context).primaryColor;
                    })),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      saveselectProduct();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NewOrder()));
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}





















/*import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:work/screens/newOrders.dart';

import '../config/config.dart';

class OrdersForm extends StatefulWidget {
  const OrdersForm({Key? key}) : super(key: key);

  @override
  State<OrdersForm> createState() => _OrdersFormState();
}

class _OrdersFormState extends State<OrdersForm> {
  List? Proditems;
  List? it;
  String selectProduct = "";
  TextEditingController barcodeController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController uomController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  void initState() {
    super.initState();
    //email = widget.email;
    getproductdatabar;
  }

  void getProductdatabar() async {
    var regBody = {};
    var response = await http.post(Uri.parse(getproductdatabar),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    Proditems = jsonResponse['success'];
    print(Proditems);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(foregroundColor: Colors.white, title: Text('select product')),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Text(
            "barcode",
            style:
                GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          //it = Proditems!['barcode'],
          //index: Proditems.length,
          /*DropDownField(
            controller: barcodeController,
            
            hintText: 'barcode',
            items: Proditems,
            itemsVisibleInDropdown: 5,
            enabled: true,
            /*icon: IconButton(onPressed: (){
              getProductdatabar()
            },),*/
            onValueChanged: (value) {
              setState(() {
                selectProduct = value;
              });
            },
          ),*/
          SizedBox(height: 15),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    "stock",
                    style: GoogleFonts.roboto(
                        fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextField(
                      controller: stockController,
                      decoration: InputDecoration(
                          hintText: 'stock',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Quantity",
                    style: GoogleFonts.roboto(
                        fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextField(
                      controller: quantityController,
                      decoration: InputDecoration(
                          hintText: 'Quatity',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onSubmitted: (String value) {},
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    "uom",
                    style: GoogleFonts.roboto(
                        fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextField(
                      controller: uomController,
                      decoration: InputDecoration(
                          hintText: 'uom',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "price",
                    style: GoogleFonts.roboto(
                        fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextField(
                      controller: priceController,
                      decoration: InputDecoration(
                          labelText: 'Price',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onSubmitted: (String value) {},
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Discount",
            style:
                GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: TextField(
              controller: discountController,
              decoration: InputDecoration(
                  labelText: 'Discount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Amount",
            style:
                GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text("hello",
              //"${int.parse(priceController.text) * int.parse(quantityController.text)}",
              style: TextStyle(fontSize: 20),
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
                  return Theme.of(context).primaryColor;
                })),
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewOrder()));
                },
              ))
        ]),
      )),
    );
  }
}
*/
/*  Row(
                children: [
                  DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: mystate,
                        iconSize: 30.0,
                        icon: (null),
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                        hint: Text('select the product'),
                        onChanged: ( NewValue) {
                          setState(() {
                            mystate = (NewValue) as String;
                            getProductdatabar();
                            print(mystate);
                          });
                        },
                        items:  Proditems?.map((item){
                          return new DropdownMenuItem(child: new Text(item['productName']),
                          value: item["id"].toString(),
                          );
                        },
                      ).toList()??[],
                    ),
                  ),
                  )
                ],
              ),  */
              