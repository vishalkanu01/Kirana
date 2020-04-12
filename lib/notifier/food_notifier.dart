import 'dart:collection';
import 'package:kiranaapp/models/food.dart';
import 'package:flutter/cupertino.dart';

class FoodNotifier with ChangeNotifier {
  List<Food> _groceriesList = [];
  List<Food> _detergentList = [];
  List<Food> _insecticideList = [];
  List<Food> _snackList = [];
  List<Food> _herbList = [];
  List<Food> _cosmeticList = [];
  //Food _currentFood;
  List<Food> userFoodCart = List();

  UnmodifiableListView<Food> get groceriesList => UnmodifiableListView(_groceriesList);
  UnmodifiableListView<Food> get detergentList => UnmodifiableListView(_detergentList);
  UnmodifiableListView<Food> get insecticideList => UnmodifiableListView(_insecticideList);
  UnmodifiableListView<Food> get snackList => UnmodifiableListView( _snackList);
  UnmodifiableListView<Food> get herbList => UnmodifiableListView(_herbList);
  UnmodifiableListView<Food> get cosmeticList => UnmodifiableListView(_cosmeticList);
 // Food get currentFood => _currentFood;

  set groceriesList(List<Food> groceriesList) {
    _groceriesList = groceriesList;
    notifyListeners();
  }
  set detergentList(List<Food> detergentList) {
    _detergentList = detergentList;
    notifyListeners();
  }
  set insecticideList(List<Food> insecticideList) {
    _insecticideList = insecticideList;
    notifyListeners();
  }
  set snackList(List<Food> snackList) {
    _snackList = snackList;
    notifyListeners();
  }
  set herbList(List<Food> herbList) {
    _herbList = herbList;
    notifyListeners();
  }
  set cosmeticList(List<Food> cosmeticList) {
    _cosmeticList = cosmeticList;
    notifyListeners();
  }

//  set currentFood(Food food) {
//    _currentFood = food;
//    notifyListeners();
//  }

  addFood(Food food) {
    _groceriesList.insert(0, food);
    notifyListeners();
  }

  addToUserCart(Food food) {
    userFoodCart.insert(0, food);
    notifyListeners();
  }

  removeFromUserCart(Food food) {
    userFoodCart.removeWhere(
            (food) => food != null
    );
    notifyListeners();
  }

  removeItemFromUserCart(Food food) {
    userFoodCart.remove(food);
    notifyListeners();
  }
}
