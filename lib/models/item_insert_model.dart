class ItemInsertModel {
  int? id;
  double? amount;
  int? quantity;
  int? nftId;

  ItemInsertModel({
    this.id,
    this.amount,
    this.quantity,
    this.nftId,
  });

  factory ItemInsertModel.fromJson(Map<String, dynamic> json){
    return ItemInsertModel(
      id: json["id"],
      amount: json["amount"],
      quantity: json["quantity"],
      nftId: json['nft_id']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "amount":amount,
      "quantity":quantity,
      "nft_id" : nftId
    };
  }
}