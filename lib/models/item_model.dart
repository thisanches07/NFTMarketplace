import 'package:nftmarketplace/models/nfts_model.dart';

class ItemModel {
  int? id;
  double? amount;
  int? quantity;
  NftModel? nft;

  ItemModel({
    this.id,
    this.amount,
    this.quantity,
    this.nft,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json){
    return ItemModel(
      id: json["id"],
      amount: json["amount"],
      quantity: json["quantity"],
      nft: NftModel.fromJson(json['nft'])
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id":id,
      "amount":amount,
      "quantity":quantity,
      "nft" : nft!.toJson()
    };
  }
}