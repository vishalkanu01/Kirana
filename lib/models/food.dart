import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  String id;
  String name;
  String category;
  String image;
  String price;
  String details;
  List subIngredients = [];
  Timestamp createdAt;
  Timestamp updatedAt;
  int quantity = 1;

  Food();

  Food.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    category = data['category'];
    image = data['image'];
    price = data['price'];
    details = data['details'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
    //quantity = data['quantity'];
  }
}
