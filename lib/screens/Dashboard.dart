import 'package:dsdweb/screens/paymentData.dart';
import 'package:dsdweb/screens/productData.dart';
//import 'package:dsdweb/screens/screen.dart';
import 'package:dsdweb/screens/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../auth/signup.dart';
import '../chartsScreen/sales.dart';
import "CustomerData.dart";
import 'orderData.dart';

class Dashboard extends StatefulWidget {
  final token;
  const Dashboard({@required this.token, super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late String email;
  //token = false  ;
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecoderToken = JwtDecoder.decode(widget.token);
    email = jwtDecoderToken['email'];
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          bottomNavigationBar: Container(
            color: Colors.orange,
            child: const TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 12,
                fontFamily: 'Monsterrat-Regular',
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(
                  text: "HOME",
                  icon: Icon(Icons.home),
                ),
                Tab(
                  text: "CUSTOMERS",
                  icon: Icon(Icons.people),
                ),
                Tab(
                  text: "ORDERS",
                  icon: Icon(Icons.shopping_cart_outlined),
                ),
                Tab(
                  text: "PRODUCTS",
                  icon: Icon(Icons.hexagon),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Text(
              "dsdsoft",

              ///isko change karna hai.
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Monsterrat-Regular',
              ),
            ),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () async {
                    widget.token == false;
                    Navigator.push(context,
                          MaterialPageRoute(builder: (c) => signup()));
                    //await FirebaseAuth.instance.signOut();
                    // instance for logout.
                  }),
            ],
          ),
          body: widget.token==null ? Center(child: CircularProgressIndicator(),):Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    crossAxisCount: 2),
                children: <Widget>[
                  GridItem(
                      icon: Icons.shopping_cart,
                      text: "Order",
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => OrderData(email: email,)));
                      }),
                  GridItem(
                      icon: Icons.payments_outlined,
                      text: "Payments",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => paymentData(email: email)));
                      }),
                  GridItem(
                    icon: Icons.people,
                    text: "Customer",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => CustomerData(email: email)));
                    },
                  ),
                  GridItem(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (c) => ProductData(
                                    email: email,
                                  )));
                    },
                    icon: Icons.hexagon,
                    text: "Product",
                  ),
                  GridItem(
                    onTap: () {Navigator.push(context,
                          MaterialPageRoute(builder: (c) => slideBar(token: widget.token)));},
                    icon: Icons.scale_sharp,
                    text: "Stock Report",
                  ),
                  GridItem(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (c) => SalesSummary()));
                    },
                    icon: Icons.analytics_outlined,
                    text: "Sales Summary",
                  ),
                ]),
          )),
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[200],
        child: InkWell(
          splashColor: Colors.grey[100],
          onHover: (value) {},
          onTap: onTap,
          child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              CircleAvatar(
                radius: 40.0,
                backgroundColor: const Color.fromARGB(255, 228, 224, 224),
                child: Icon(
                  icon,
                  color: Colors.orange[400],
                  size: 40.0,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Monsterrat-Regular',
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
