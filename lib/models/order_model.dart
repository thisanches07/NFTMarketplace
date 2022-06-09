import 'package:nftmarketplace/models/item_model.dart';
import 'package:nftmarketplace/models/user_model.dart';

class OrderModel {
  int? id;
  UserModel? user; 
  String? date;
  List<ItemModel>? items;

  OrderModel({
    this.id,
    this.user,
    this.date,
    this.items
  });

  factory OrderModel.fromJson(Map<String, dynamic> json){
    late List items = json["items"];
    return OrderModel(
      id: json["id"],
      user: UserModel.fromJson(json["user"]),
      date: json["date"],
      items: items.map((e) => ItemModel.fromJson(e)).toList()
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "user": user!.toJson(),
      "date": date,
      "items" : items!.map((e) => e.toJson())
    };
  }
}