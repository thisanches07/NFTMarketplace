class Nft {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<NftModel> _nfts;
  List<NftModel> get nfts => _nfts;

  Nft({ required totalSize,  required typeId,  required offset, required nfts}){
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._nfts = nfts;
  }

  Nft.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['nfts'] != null) {
      _nfts = <NftModel>[];
      json['nfts'].forEach((v) {
        NftModel test = new NftModel.fromJson(v);
        _nfts.add(test);
      });
    }
  }
}

class NftModel {
  int? id;
  String? name;
  String? description;
  double? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  NftModel(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.stars,
        this.img,
        this.location,
        this.createdAt,
        this.updatedAt,
        this.typeId});

  NftModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

}