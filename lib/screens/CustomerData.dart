import 'dart:convert';
import 'package:flutter/material.dart';
import '../config/config.dart';
import 'package:http/http.dart' as http;

import 'addcustomer.dart';

class CustomerData extends StatefulWidget {
  final email;
  const CustomerData({@required this.email, super.key});

  @override
  State<CustomerData> createState() => _CustomerDataState();
}

class _CustomerDataState extends State<CustomerData> {
  List? cusitems;
  late String email = widget.email;
  @override
  void initState() {
    super.initState();
    email = widget.email;
    getcustomerData(widget.email);
  }
  void getcustomerData(email) async {
    var regBody = {"email": widget.email};
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
    if (jsonResponse['status']){  
      getcustomerData(email);
    }
    //items = jsonResponse['success'];
  }

  @override
  Widget build(BuildContext context) {
    //getcustomerData(widget.email);
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
                                      Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                'Order - ${cusitems![index]['customerCode']}'),
                                            Text(
                                                'Name - ${cusitems![index]['name']}'),
                                            Text(
                                                'contact No - ${cusitems![index]['contactNo']}'),
                                          ]),
                                      IconButton(
                                        alignment: Alignment.bottomRight,
                                        onPressed: () {
                                          //action coe when button is pressed
                                          //print('${items![index]['_id']}');
                                          deletecustomerdata(
                                              '${cusitems![index]['_id']}');
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
                      builder: (context) => CustomerForm(
                            email: widget.email,
                          )));
            }));
  }
}






































/*import 'dart:convert';
import 'package:flutter/material.dart';
import '../config/config.dart';
import 'package:http/http.dart' as http;

class CustomerData extends StatefulWidget {
  final email;
  const CustomerData({@required this.email, super.key});

  @override
  State<CustomerData> createState() => _CustomerDataState();
}

class _CustomerDataState extends State<CustomerData> {
  List? items;
  late String email = widget.email;

  void getcustomerData(email) async {
    var regBody = {"email": widget.email};
    var response = await http.post(
        Uri.parse(
          getcustomerdata,
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody));
    var jsonResponse = jsonDecode(response.body);
    items = jsonResponse['success'];
    setState(() {});
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        title: Text("${items}"),
      ),
    );
  }
}
*/


/*var response = await http.get(
      Uri.parse(getcustomerdata),
      headers: {"Content-Type": "application/json"},
    
    );*/


//print(res);
    //print(await response.stream.bytesToString());

    //var jsonResponse = await json.decode(response.stream as String);
    //print(jsonResponse);
    //items = jsonDecode(response.stream as String);
    //*/
    /*
    var response = await http.post(Uri.parse(getcustomerdata),
        body: jsonEncode(regBody),
        headers: {"Content-Type": "application/json"});
    //print(regBody);
    /*var response = await http.get(
      Uri.parse(getcustomerdata),
      headers: {"Content-Type": "application/json"},
      //body: jsonEncode(regBody),
    );
    //print(response.body);
    //print(jsonDecode(response.body));*/
    var res = jsonDecode(response.body);
    //var responseData = json.decode(response.body);
    print(res);
    var respon = res['success'];
    print(respon);

    //print(jsonDecode(responseData["success"]));
    //Map<String,dynamic> res = json.decode(responseData["success"]);
    //print(res);*/
    

        /*
        body: Container(
          padding: EdgeInsets.fromLTRB(5, 10, 10, 5),
          //height: MediaQuery.of(context).size.height,
          //width: MediaQuery.of(context).size.width,
          color: Colors.white70,
          child: items == null
              ? null
              : ListView.builder(
                  itemCount: items?.length,
                  itemBuilder: (context, int index) {
                    return SizedBox(
                      height: 200,
                      //width: MediaQuery.of(context).size.width,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10, top: 10),
                        //elevation: 150,
                        color: Colors.grey[300],
                        //shadowColor: Colors.white70,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(children: [
                                ListTile(

                                    title: Text(
                                      
                                  '${items![index]['email']}',
                                )
                                    ),

                                /*Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Text("name",
                                            style: GoogleFonts.roboto(
                                                fontSize: 20))),
                                    SizedBox(
                                      height: 5,
                                    ),*/
                              ]),
                              Container(
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                      ),
                                      onPressed: () async {}))
                            ]),
                      ),
                    );
                  }),
        ),*/
        /* body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(         
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${items}'),
                child: items == null
                    ? null
                    : ListView.builder(
                        itemCount: items!.length,
                        itemBuilder: (context, int index) {
                          return Slidable(
                            key: const ValueKey(0),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              dismissible: DismissiblePane(onDismissed: () {}),
                              children: [
                                SlidableAction(
                                  backgroundColor: Color(0xFFFE4A49),
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  onPressed: (BuildContext context) {
                                    //print('${items![index]['_id']}');
                                    //deleteItem('${items![index]['_id']}');
                                  },
                                ),
                              ],
                            ),
                            child: Card(
                              borderOnForeground: false,
                              child: ListTile(
                                leading: Icon(Icons.task),
                                title: Text('${items![index]['street']}'),
                                subtitle:
                                    Text('${items![index]['customercode']}'),
                                trailing: Icon(Icons.arrow_back),
                              ),
                            ),
                          );
                        }),
              ),
            ),
          ],
        ),*/
    