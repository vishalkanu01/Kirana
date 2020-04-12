import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiranaapp/models/food.dart';
import 'package:kiranaapp/models/post.dart';
import 'package:kiranaapp/models/user.dart';
import 'package:flutter/services.dart';
import 'package:kiranaapp/notifier/food_notifier.dart';
import 'package:kiranaapp/ui/views/category/detergentPage.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');
  final CollectionReference _postsCollectionReference =
      Firestore.instance.collection('posts');

  final StreamController<List<Post>> _postsController =
      StreamController<List<Post>>.broadcast();

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future addPost(Post post) async {
    try {
      await _postsCollectionReference.add(post.toMap());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future getPostsOnceOff() async {
    try {
      var postDocumentSnapshot = await _postsCollectionReference.getDocuments();
      if (postDocumentSnapshot.documents.isNotEmpty) {
        return postDocumentSnapshot.documents
            .map((snapshot) => Post.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
      }
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Stream listenToPostsRealTime() {
    // Register the handler for when the posts data changes
    _postsCollectionReference.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.documents.isNotEmpty) {
        var posts = postsSnapshot.documents
            .map((snapshot) => Post.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.title != null)
            .toList();

        // Add the posts onto the controller
        _postsController.add(posts);
      }
    });

    return _postsController.stream;
  }

  Future deletePost(String documentId) async {
    await _postsCollectionReference.document(documentId).delete();
  }

  Future updatePost(Post post) async {
    try {
      await _postsCollectionReference
          .document(post.documentId)
          .updateData(post.toMap());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}

getGroceries(FoodNotifier foodNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Foods')
      .where('category', isEqualTo: 'Groceries')
      .getDocuments();

  List<Food> _groceriesList = [];

  snapshot.documents.forEach((document) {
    Food food = Food.fromMap(document.data);
    _groceriesList.add(food);
  });

  foodNotifier.groceriesList = _groceriesList;
}

getDetergent(FoodNotifier foodNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Foods')
      .where('category', isEqualTo: 'Detergent')
      .getDocuments();

  List<Food> _detergentList = [];

  snapshot.documents.forEach((document) {
    Food food = Food.fromMap(document.data);
    _detergentList.add(food);
  });

  foodNotifier.detergentList = _detergentList;
}

getInsecticide(FoodNotifier foodNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Foods')
      .where('category', isEqualTo: 'Insecticide')
      .getDocuments();

  List<Food> _insecticideList = [];

  snapshot.documents.forEach((document) {
    Food food = Food.fromMap(document.data);
    _insecticideList.add(food);
  });

  foodNotifier.insecticideList = _insecticideList;
}

getSnack(FoodNotifier foodNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Foods')
      .where('category', isEqualTo: 'Snack')
      .getDocuments();

  List<Food> _snackList = [];

  snapshot.documents.forEach((document) {
    Food food = Food.fromMap(document.data);
    _snackList.add(food);
  });

  foodNotifier.snackList = _snackList;
}

getHerb(FoodNotifier foodNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Foods')
      .where('category', isEqualTo: 'Herb')
      .getDocuments();

  List<Food> _herbList = [];

  snapshot.documents.forEach((document) {
    Food food = Food.fromMap(document.data);
    _herbList.add(food);
  });

  foodNotifier.herbList = _herbList;
}

getCosmetic(FoodNotifier foodNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('Foods')
      .where('category', isEqualTo: 'Cosmetic')
      .getDocuments();

  List<Food> _cosmeticList = [];

  snapshot.documents.forEach((document) {
    Food food = Food.fromMap(document.data);
    _cosmeticList.add(food);
  });

  foodNotifier.cosmeticList = _cosmeticList;
}
class ProductService {
  Firestore _firestore = Firestore.instance;
  String ref = 'Orders';

  void uploadProduct(Map<String, dynamic> data) {
    var id = Uuid();
    String productId = id.v1();
    data["id"] = productId;
    _firestore.collection(ref).document(productId).setData(data);
  }
}
