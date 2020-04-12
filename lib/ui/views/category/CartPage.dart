import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kiranaapp/services/authentication_service.dart';
import 'package:kiranaapp/services/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:kiranaapp/models/food.dart';
import 'package:kiranaapp/notifier/food_notifier.dart';
import 'package:flutter/rendering.dart';
import '../../../locator.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ProductService productService = ProductService();
  bool uploaded = false;

  Food get food => null;
  double _buttonWidth = 30;

  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text('Cart'),
      ),
      body: Form(
          key: _formKey,
          child: ListView.builder(
              itemCount: foodNotifier.userFoodCart.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    // ============ leading section==================
                    leading: new Image.network(
                      foodNotifier.userFoodCart[index].image,
                      width: 60.0,
                      height: 100.0,
                    ),
                    //========= Title section========
                    title: new Text(
                      foodNotifier.userFoodCart[index].name,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    //============Subtitle section=============
                    subtitle: new Column(
                      children: <Widget>[
//   ===================== This section is for the product price==============
                        new Container(
                          alignment: Alignment.topLeft,
                          child: new Text(
                            "\RS ${foodNotifier.userFoodCart[index].price}",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        )
                      ],
                    ),
                    trailing: Container(
                      margin: EdgeInsets.only(right: 0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300], width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            width: _buttonWidth,
                            height: _buttonWidth,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                setState(() {
                                  if (foodNotifier
                                          .userFoodCart[index].quantity ==
                                      1) {
                                    foodNotifier.userFoodCart.removeAt(index);
                                  } else {
                                    foodNotifier.userFoodCart[index].quantity--;
                                  }
                                });
                              },
                              child: Text(
                                "-",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 25),
                              ),
                            ),
                          ),
                          Text(
                            foodNotifier.userFoodCart[index].quantity
                                .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          SizedBox(
                            width: _buttonWidth,
                            height: _buttonWidth,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                setState(() {
                                  foodNotifier.userFoodCart[index].quantity++;
                                });
                              },
                              child: Text(
                                "+",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
          //new Cart_products()
          ),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
                child: ListTile(
              title: new Text("Total:"),
              subtitle:
                  Text("\Rs = ${returnTotalAmount(foodNotifier.userFoodCart)}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),
            )),
            Expanded(
              child: new MaterialButton(
                onPressed: () {
                  _onsaved();
                },
                child: new Text(
                  "Check out",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }

  returnTotalAmount(List<Food> userFoodCart) {
    int totalAmount = 0;
    for (int i = 0; i < userFoodCart.length; i++) {
      var price = int.parse(userFoodCart[i].price);
      totalAmount = totalAmount + price * userFoodCart[i].quantity;
    }
    return totalAmount;
  }

  void _onsaved() async {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    final AuthenticationService _authenticationService =
    locator<AuthenticationService>();
     var currentUser = _authenticationService.currentUser;
    int i;
    if (_formKey.currentState.validate()) {
      setState(() => uploaded = true);
      for (i = 0; i < foodNotifier.userFoodCart.length; i++) {
        productService.uploadProduct({
          "Order Time": Timestamp.now(),
          "User ID": currentUser.id.toString(),
          "User Name":currentUser.fullName.toString(),
          "name": foodNotifier.userFoodCart[i].name.toString(),
          "image": foodNotifier.userFoodCart[i].image.toString(),
          "price": foodNotifier.userFoodCart[i].price.toString(),
          "quantity": foodNotifier.userFoodCart[i].quantity.toString(),
        });
        Fluttertoast.showToast(msg: 'Your order is placed.');
      }
    } else {
      setState(() => uploaded = false);
    }
    if (uploaded = true) {
      print("delete was called");
      removeFromCart(foodNotifier.userFoodCart);
    }
  }

  void removeFromCart(List<Food> userFoodCart) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    foodNotifier.removeFromUserCart(food);
  }
}
