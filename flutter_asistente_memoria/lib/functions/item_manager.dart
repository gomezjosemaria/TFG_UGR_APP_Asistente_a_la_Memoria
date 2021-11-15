
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_asistente_memoria/model/item_model.dart';

class ItemManager {

  static CollectionReference _collectionReferenceItems =
  FirebaseFirestore.instance.collection('items');
  static List<ItemModel> _itemsList = <ItemModel>[];
  static List<ItemModel> _itemsCart = <ItemModel>[];

  static Future<void> saveItem(ItemModel item, String userEmail) async {
    if (item.cart == false) {
      try {
        await _collectionReferenceItems
            .doc(userEmail)
            .collection('list')
            .doc(item.name)
            .set({
          'name': item.name,
        });
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
    else {
      try {
        await _collectionReferenceItems
            .doc(userEmail)
            .collection('cart')
            .doc(item.name)
            .set({
          'name': item.name,
        });
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
  }

  static loadItems(String userEmail) async {
    try {
      var collectionReferenceItemsList = _collectionReferenceItems.doc(userEmail).collection('list');
      var collectionReferenceItemsCart = _collectionReferenceItems.doc(userEmail).collection('cart');

      QuerySnapshot querySnapshotList = await collectionReferenceItemsList.get();
      QuerySnapshot querySnapshotCart = await collectionReferenceItemsCart.get();

      _itemsList.clear();
      for (int i = 0; i < querySnapshotList.docs.length; i++) {
        var item = querySnapshotList.docs[i];
        var itemModel = new ItemModel(
          item.data()['name'].toString(),
          false,
        );
        _itemsList.add(itemModel);
      }

      _itemsCart.clear();
      for (int i = 0; i < querySnapshotCart.docs.length; i++) {
        var item = querySnapshotCart.docs[i];
        var itemModel = new ItemModel(
          item.data()['name'].toString(),
          true,
        );
        _itemsCart.add(itemModel);
      }
    } on FirebaseException catch (e) {
      throw (e);
    }
  }

  static getItemsList() {
    return _itemsList;
  }

  static getItemsCart() {
    return _itemsCart;
  }

  static deleteItem(ItemModel item, String userEmail) async {
    if (item.cart == false) {
      try {
        var collectionReferenceItemsList = _collectionReferenceItems.doc(userEmail).collection('list');
        await collectionReferenceItemsList.doc(item.name).delete();
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
    else {
      try {
        var collectionReferenceItemsCart = _collectionReferenceItems.doc(userEmail).collection('cart');
        await collectionReferenceItemsCart.doc(item.name).delete();
      } on FirebaseException catch (e) {
        throw (e);
      }
    }
  }

  static moveItem(ItemModel item, String userEmail) async {
    ItemModel itemMoved = ItemModel(item.name, !item.cart);
    await deleteItem(item, userEmail);
    await saveItem(itemMoved, userEmail);
    await loadItems(userEmail);
  }
}