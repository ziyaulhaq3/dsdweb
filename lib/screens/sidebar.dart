import 'package:dsdweb/screens/addcustomer.dart';
import 'package:dsdweb/screens/paymentform.dart';
import 'package:dsdweb/screens/productForm.dart';
import "package:flutter/material.dart";
import 'package:jwt_decoder/jwt_decoder.dart';
import "package:sidebarx/sidebarx.dart";
import 'package:dsdweb/config/config.dart';
import 'package:dsdweb/screens/newOrders.dart';
//import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import "newOrders.dart";

class slideBar extends StatefulWidget {
  final token;
  const slideBar({@required this.token, super.key});

  @override
  State<slideBar> createState() => _slideBarState();
}

class _slideBarState extends State<slideBar> {
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();
  @override
  List? payitems;
  List? Pitems;
  List? Orderitems;
  List? cusitems;
  String? email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecoderToken = JwtDecoder.decode(widget.token);
    email = jwtDecoderToken['email'];
    getnewOrderdata(email);
  }

  void getproductData(email) async {
    var regBody = {"email": email};
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

  void deleteproductdata(id) async {
    print(id);
    var regBody = {"_id": id};
    var response = await http.post(Uri.parse(deleteProductdata),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      getproductData(email);
    }
    //items = jsonResponse['success'];
  }

  void getpaymentData(email) async {
    var regBody = {"email": email};
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

  void getcustomerData(email) async {
    var regBody = {"email": email};
    var response = await http.post(Uri.parse(getcustomerdata),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    cusitems = jsonResponse['success'];
    print(cusitems);
    //it = prdoitems.length

    setState(() {
      cusitems = jsonResponse['success'];
    });
  }

  void deletecustomerdata(id) async {
    print(id);
    var regBody = {"_id": id};
    var response = await http.post(Uri.parse(deletecutomerdata),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      getcustomerData(email);
    }
    //items = jsonResponse['success'];
  }

  void getnewOrderdata(email) async {
    var regBody = {"email": email};
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
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Scaffold(
        key: _key,
        appBar: isSmallScreen
            ? AppBar(
                title: Text('SideBarX Example'),
                leading: IconButton(
                  onPressed: () {
                    _key.currentState?.openDrawer();
                  },
                  icon: Icon(Icons.menu),
                ),
              )
            : null,
        drawer: SideBarXExample(
          controller: _controller,
        ),
        body: Row(
          children: [
            if (!isSmallScreen) SideBarXExample(controller: _controller),
            Expanded(
                child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  switch (_controller.selectedIndex) {
                    case 0:
                      _key.currentState?.closeDrawer();

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
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              //borderOnForeground: false,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Card(
                                                  shadowColor: Colors.grey,
                                                  color: Colors.grey[100],
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                              Text(
                                                                  'barcode - ${Pitems![index]['barcode']}', style: TextStyle(color: Colors.amber),),
                                                                  //SizedBox(width: 15,),
                                                              Text(
                                                                  'Product Name - ${Pitems![index]['productName']}'),
                                                                  //SizedBox(width: 15,),
                                                              Text(
                                                                  'Price - ${Pitems![index]['productPrice']}'),
                                                            
                                                            //SizedBox(width: 15,),
                                                        Text('stock'),
                                                        Text(
                                                            "${Pitems![index]['stock']}"),
                                                        IconButton(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          onPressed: () {
                                                            //action coe when button is pressed
                                                            //print('${items![index]['_id']}');
                                                            deleteproductdata(
                                                                '${Pitems![index]['_id']}');
                                                          },
                                                          icon: Icon(
                                                              Icons.delete),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }))),
                          floatingActionButton: SizedBox(width: 120,
                            child: ElevatedButton(
                                child: Row(
                                  children: [
                                    Icon(Icons.add, color: Colors.white),
                                  Text('Add',style: TextStyle(color: Colors.white),)  
                                  ],
                                ),
                                //backgroundColor: Colors.amber,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => productForm(
                                                email: email,
                                              )));
                                }),
                          ));
                      ;
                    /* return Stack(children: [
                        Positioned(
                          left: 10,
                          top: 111,
                          child: Text(
                            "Product",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 36,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 723,
                          top: 101,
                          child: Container(
                            width: 166,
                            height: 60,

                            padding: const EdgeInsets.only(
                              left: 17,
                              right: 18,
                            ),
                            //SizedBox(width: 5),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => productForm(
                                              email: widget.email,
                                            )));
                              },
                              child: const Text(
                                "Add item",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 200,
                          top: 237,
                          child: Text(
                            "Barcode",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 360,
                          top: 237,
                          child: Text(
                            "Stock",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 490,
                          top: 237,
                          child: Text(
                            "Quantity",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 700,
                          top: 237,
                          child: Text(
                            "Price",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 900,
                          top: 237,
                          child: Text(
                            "VOM",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Positioned(
                            left: 2,
                            top: 278,
                            child: Container(
                              width: 967,
                              height: 68,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xfff4f4f4),
                              ),
                              padding: const EdgeInsets.only(
                                left: 26,
                                right: 14,
                                top: 17,
                                bottom: 19,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "#1345",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xfff59359),
                                      fontSize: 20,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 120),
                                  Text(
                                    "100",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 120),
                                  Text(
                                    "160",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 120),
                                  Text(
                                    "6000",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 140),
                                  Text(
                                    "6000",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ))
                      ]); */
                    case 1:
                      _key.currentState?.closeDrawer();
                      getproductData(email);
                      return Scaffold(
                          backgroundColor: Colors.grey[100],
                          appBar: AppBar(
                            foregroundColor: Colors.white,
                            title: Text('Order'),
                            backgroundColor: Colors.orange,
                            automaticallyImplyLeading: false,
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
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              //borderOnForeground: false,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Card(
                                                  shadowColor: Colors.grey,
                                                  color: Colors.grey[100],
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'orderId - ${Orderitems![index]['orderId']}',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .amber,
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      "Montserrat",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              Text(
                                                                  'customer Name - ${Orderitems![index]['customerName']}'),
                                                              SizedBox(
                                                                width: 20,
                                                              ),
                                                              Text(
                                                                  'Date - ${Orderitems![index]['createdAt']}'),

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
                          floatingActionButton: SizedBox(
                            width: 120,
                            child: ElevatedButton(
                                child: Row(
                                  children: [
                                    Icon(Icons.add, color: Colors.white),
                                    Text('Add',style: TextStyle(color: Colors.white),)
                                  
                                  ],
                                ),
                                //backgroundColor: Colors.amber,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewOrder(
                                                email: email,
                                              )));
                                }),
                          ));
                    case 2:
                      _key.currentState?.closeDrawer();
                      getcustomerData(email);
                      return Scaffold(
                          backgroundColor: Colors.grey[100],
                          appBar: AppBar(
                            foregroundColor: Colors.white,
                            title: Text('Customer'),
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
                                  child: cusitems == null
                                      ? null
                                      : ListView.builder(
                                          itemCount: cusitems!.length,
                                          itemBuilder: (context, int index) {
                                            return Container(
                                              height: 100,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              //borderOnForeground: false,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(7.0),
                                                child: Card(
                                                  shadowColor: Colors.grey,
                                                  color: Colors.grey[100],
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                       
                                                              Text(
                                                                  'customerCode - ${cusitems![index]['customerCode']}', style: TextStyle(color: Colors.amber),),
                                                                  SizedBox(width: 55,),
                                                              Text(
                                                                  'Name - ${cusitems![index]['name']}'),
                                                                  SizedBox(width: 55,),
                                                                  //SizedBox(width: 15,)
                                                              Text(
                                                                  'contact No - ${cusitems![index]['contactNo']}'),
                                                                      SizedBox(width: 55,),
                                                              Text(
                                                                  'street - ${cusitems![index]['street']}'),
                                                                      SizedBox(width: 55,),
                                                              Text(
                                                                  'VAT NO - ${cusitems![index]['vatNo']}'),
                                                              

                                                        IconButton(
                                                          alignment: Alignment
                                                              .bottomRight,
                                                          onPressed: () {
                                                            //action coe when button is pressed
                                                            //print('${items![index]['_id']}');
                                                            deletecustomerdata(
                                                                '${cusitems![index]['_id']}');
                                                          },
                                                          icon: Icon(
                                                              Icons.delete),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }))),
                          floatingActionButton: SizedBox(
                            width: 120,
                            child: ElevatedButton(
                                child: Row(
                                  children: [
                                    Icon(Icons.add, color: Colors.white),
                                    Text('Add',style: TextStyle(color: Colors.white),)
                                  ],
                                ),
                                //backgroundColor: Colors.amber,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CustomerForm(
                                                email: email,
                                              )));
                                }),
                          ));
                    case 3:
                      _key.currentState?.closeDrawer();
                      getpaymentData(email);
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
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: payitems == null
                                    ? null
                                    : ListView.builder(
                                        itemCount: payitems!.length,
                                        itemBuilder: (context, int index) {
                                          return Container(
                                            height: 100,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            //borderOnForeground: false,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(7.0),
                                              child: Card(
                                                shadowColor: Colors.grey,
                                                color: Colors.grey[100],
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      
                                                            Text(
                                                                'paymentId - ${payitems![index]['paymentId']}', style: TextStyle(color: Colors.amber),),
                                                            //SizedBox(width: 15,),
                                                            Text(
                                                                'customerName - ${payitems![index]['customerName']}'),
                                                            Text(
                                                                'balance - ${payitems![index]['balance']}'),
                                                      //SizedBox(width: 15,),  
                                                      Text(
                                                        "status - ",
                                                      ),
                                                      IconButton(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        onPressed: () {
                                                          //action coe when button is pressed
                                                        },
                                                        icon: Icon(
                                                            Icons.edit_note),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }))),
                        floatingActionButton: SizedBox(
                          width: 100,
                          child: ElevatedButton(
                            
                              child: Row(
                                children: [
                                  Icon(Icons.add, color: Colors.white),
                                  Text('Add',style: TextStyle(color: Colors.white) ,)
                                ],
                              ),
                              //Color: Colors.orange,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PaymentForm(
                                              email: email,
                                            )));
                              }),
                        ),
                      );
                    default:
                      return Center(
                        child: Text(
                          'Home',
                          style: TextStyle(color: Colors.black, fontSize: 40),
                        ),
                      );
                  }
                },
              ),
            ))
          ],
        ));
  }
}

class SideBarXExample extends StatelessWidget {
  const SideBarXExample({Key? key, required SidebarXController controller})
      : _controller = controller,
        super(key: key);
  final SidebarXController _controller;
  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: const SidebarXTheme(
        decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        selectedTextStyle: const TextStyle(color: Colors.white),
      ),
      extendedTheme: const SidebarXTheme(width: 250),
      footerDivider: Divider(color: Colors.white.withOpacity(0.8), height: 1),
      headerBuilder: (context, extended) {
        return  SizedBox(
          height: 100,
          child: Column(
            children: [
              Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
                
              ),
            ],
          ),
        );
      },
      items: const [
        SidebarXItem(
          icon: Icons.hexagon,
          label: 'Product',
        ),
        SidebarXItem(
          icon: Icons.shopping_cart,
          label: 'order',
        ),
        SidebarXItem(icon: Icons.people, label: 'Customer'),
        SidebarXItem(icon: Icons.money, label: 'Payment'),
      ],
    );
  }
}
