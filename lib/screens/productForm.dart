import "dart:convert";
import "dart:io";
import "package:fluttertoast/fluttertoast.dart";
import 'package:http/http.dart' as http;
//import "dart:html";

import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

import "../config/config.dart";
import "productData.dart";

class productForm extends StatefulWidget {
  final email;
  const productForm({@required this.email, super.key});

  @override
  State<productForm> createState() => _productFormState();
}

class _productFormState extends State<productForm> {
  TextEditingController barcodeController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController ProductPrizeController = TextEditingController();
  String selectedImagePath = "";

  void productdatatomongo() async {
    if (barcodeController.text.isNotEmpty &&
        productNameController.text.isNotEmpty &&
        stockController.text.isNotEmpty &&
        ProductPrizeController.text.isNotEmpty) {
      var regbody = {
        "email": widget.email,
        "Image": selectedImagePath,
        "barcode": barcodeController.text,
        "productName": productNameController.text,
        "stock": stockController.text,
        "productPrice": ProductPrizeController.text
      };
      var response = await http.post(Uri.parse(addProduct),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regbody));
      var jsonResponse = jsonDecode(response.body);
      //print(jsonResponse['status']);
      if (jsonResponse['status']) {
      } else {
        print("something went wrong");
      }
    }
    Fluttertoast.showToast(msg: 'Data Added Successfully!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          "Productform",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  selectedImagePath == ""
                      ? Container(
                          height: 150,
                          width: 350,
                          color: Colors.grey,
                          child: Center(child: Icon(Icons.image_search)))
                      : Image.file(
                          File(selectedImagePath),
                          height: 150,
                          width: 350,
                          fit: BoxFit.fill,
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      selectImage();
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )),
                    child: const Text(
                      "SELECT",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        wordSpacing: 3,
                      ),
                    ),
                    //child: Text("select")
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Barcode",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                        fontFamily: "Monsterrat-Regular",
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: barcodeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "162001",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Product Name",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                        fontFamily: "Monsterrat-Regular",
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: productNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          //labelText: 'Customer Code',
                          hintText: "laptop",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "stock",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                        fontFamily: "Monsterrat-Regular",
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      controller: stockController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          //labelText: 'Customer Code',
                          hintText: "100",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Product Prize",
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 16,
                        fontFamily: "Monsterrat-Regular",
                        fontWeight: FontWeight.bold),
                  ),
                  TextField(
                    controller: ProductPrizeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        //labelText: 'Customer Code',
                        hintText: "50000",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                            productdatatomongo();
                            //saveCustomer();
                            Navigator.pop(context);
                          }))
                ]),
          ),
        ),
      ),
    );
  }

  Future selectImage() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: 200,
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      "select image",
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromGallery();
                            print("image path:-");
                            print(selectedImagePath);
                            if (selectedImagePath != "") {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("no image selecteed"),
                              ));
                            }
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                      height: 60,
                                      width: 60,
                                      color: Colors.grey,
                                      child: Icon(Icons.photo_album_outlined)),
                                  Text(
                                    "gallery",
                                    style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            selectedImagePath = await selectImageFromCamera();
                            print("image path:-");
                            print(selectedImagePath);
                            if (selectedImagePath != "") {
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("no image selecteed"),
                              ));
                            }
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                      height: 60,
                                      width: 60,
                                      color: Colors.grey,
                                      child: Icon(Icons.camera_alt)),
                                  Text(
                                    "camera",
                                    style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return "";
    }
  }

  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return "";
    }
  }
}
