
import 'package:nftmarketplace/models/item_insert_model.dart';

class OrderInsertModel {
  int? id;
  int? userId; 
  String? date;
  List<ItemInsertModel>? items;

  OrderInsertModel({
    this.id,
    this.userId,
    this.date,
    this.items
  });

  factory OrderInsertModel.fromJson(Map<String, dynamic> json){
    late List items = json["items"];
    return OrderInsertModel(
      id: json["id"],
      userId: json["user_id"],
      date: json["date"],
      items: items.map((e) => ItemInsertModel.fromJson(e)).toList()
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "user_id": userId,
      "date": date,
      "items" : items!.map((e) => e.toJson()).toList()
    };
  }
}