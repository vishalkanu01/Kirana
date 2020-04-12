import 'package:flutter/material.dart';
import 'package:kiranaapp/models/food.dart';
import 'package:kiranaapp/notifier/food_notifier.dart';
import 'package:kiranaapp/services/firestore_service.dart';
import 'package:kiranaapp/ui/views/category/CartPage.dart';
import 'package:provider/provider.dart';

class Cosmetics extends StatefulWidget {
  @override
  _CosmeticsState createState() => _CosmeticsState();
}

class _CosmeticsState extends State<Cosmetics> {
  @override
  void initState() {
    FoodNotifier foodNotifier =
        Provider.of<FoodNotifier>(context, listen: false);
    getCosmetic(foodNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);
    Future<void> _refreshList() async {
      getCosmetic(foodNotifier);
    }

    addToCart(Food food) {
      foodNotifier.addToUserCart(food);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Cosmetics"),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
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
      body: Stack(children: <Widget>[
        RefreshIndicator(
          child: Positioned(
            top: 2,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(color: Colors.blueGrey[100]),
              child: ListView.builder(
                  itemCount: foodNotifier.cosmeticList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return (Container(
                      height: 100,
                      margin: EdgeInsets.only(bottom: 16, left: 5, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image: NetworkImage(foodNotifier
                                          .cosmeticList[index].image))),
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8, top: 8),
                              // decoration: BoxDecoration(color: Colors.blue),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    foodNotifier.cosmeticList[index].name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 24),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                            "\RS ${foodNotifier.cosmeticList[index].price}"),
                                        RaisedButton(
//
                                          color: Colors.red,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(500))),
                                          child: Center(
                                            child: Text(
                                              "Add To Cart",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11),
                                            ),
                                          ),
                                          onPressed: () {
                                            addToCart(foodNotifier
                                                .cosmeticList[index]);
                                            final snackBar = SnackBar(
                                              content: Text(
                                                  '${foodNotifier.cosmeticList[index].name} added to Cart'),
                                              duration:
                                                  Duration(milliseconds: 1000),
                                            );

                                            Scaffold.of(context)
                                                .showSnackBar(snackBar);
                                          },
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ));
                  }),
            ),
          ),
          onRefresh: _refreshList,
        ),
      ]),
    );
  }
}
