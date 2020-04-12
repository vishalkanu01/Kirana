import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiranaapp/models/user.dart';
import 'package:kiranaapp/notifier/food_notifier.dart';
import 'package:kiranaapp/services/authentication_service.dart';
import 'package:kiranaapp/ui/shared/ui_helpers.dart';
import 'package:kiranaapp/ui/views/category/CartPage.dart';
import 'package:kiranaapp/ui/views/category/cosmetics.dart';
import 'package:kiranaapp/ui/views/category/detergentPage.dart';
import 'package:kiranaapp/ui/views/category/herbs.dart';
import 'package:kiranaapp/ui/views/category/insecticides.dart';
import 'package:kiranaapp/ui/views/category/snacks.dart';
import 'package:kiranaapp/ui/views/login_view.dart';
import 'package:kiranaapp/ui/views/myProfile.dart';
import 'package:provider/provider.dart';

import '../../locator.dart';
import 'category/groceries.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  User get currentUser => _authenticationService.currentUser;

  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);

    Widget image_carousel = new Container(
      height: 250,
      child: Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('assets/images/1.jpg'),
          AssetImage('assets/images/2.png'),
          AssetImage('assets/images/3.png'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 1.0,
        dotBgColor: Colors.transparent,
      ),
    );
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Kirana',
              style: TextStyle(color: Colors.deepOrangeAccent),
            ),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartPage()));
                },
                child: new Stack(
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                      ),
                      onPressed: null,
                    ),
                    new Positioned(
                        child: new Stack(
                      children: <Widget>[
                        new Icon(Icons.brightness_1,
                            size: 25.0, color: Colors.blueAccent),
                        new Positioned(
                            top: 5.0,
                            right: 8.5,
                            child: new Center(
                              child: new Text(
                                foodNotifier.userFoodCart.length.toString(),
                                style: new TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                      ],
                    )),
                  ],
                ),
              )
            ],
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  accountName: Text(
                    currentUser.fullName,
                    style: TextStyle(fontSize: 20),
                  ),
                  accountEmail: Text(
                    currentUser.email,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                        ));
                  },
                  child: ListTile(
                    title: Text('My Profile'),
                    leading: Icon(
                      Icons.person,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ),
                InkWell(
                  onTap: null,
                  child: ListTile(
                    title: Text('My Cart'),
                    leading: Icon(
                      Icons.shopping_cart,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ),
                spacedDivider,
                InkWell(
                  onTap: () {
                    FirebaseAuth.instance
                        .signOut()
                        .catchError((error) => print(error.code));
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (context) => LoginView()));
                  },
                  child: ListTile(
                    title: Text('Log Out'),
                    leading: Icon(
                      Icons.keyboard_backspace,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: <Widget>[
              //=============image carousel=================
              image_carousel,
              new Padding(
                padding: const EdgeInsets.all(0.0),
                // child: Text('Categories'),
              ),
//========================== padding widget================
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'CATEGORIES:',
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          color: Colors.red,
                          fontSize: 15),
                    )),
              ),
              Expanded(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detergent(),
                                ));
                          },
                          // leading: Image.asset('assets/images/icon_large.png'),
                          title: Text("Detergent"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Groceries(),
                                ));
                          },
                          //leading: Image.asset('assets/images/icon_large.png'),
                          title: Text("Groceries"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Insecticides(),
                                ));
                          },
                          // leading: Image.asset('assets/images/icon_large.png'),
                          title: Text("Insecticide"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Snacks(),
                                ));
                          },
                          // leading: Image.asset('assets/images/icon_large.png'),
                          title: Text("Snacks"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Herbs(),
                                ));
                          },
                          // leading: Image.asset('assets/images/icon_large.png'),
                          title: Text("Herbs"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Cosmetics(),
                                ));
                          },
                          // leading: Image.asset('assets/images/icon_large.png'),
                          title: Text("Cosmetics"),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
