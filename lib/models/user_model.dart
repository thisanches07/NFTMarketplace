class UserModel {

  int id;
  String name;
  String username;
  String phone;
  int orderCount;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.phone,
    required this.orderCount
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      phone: json['phone'],
      orderCount: json['orderCount']
    );
  }
}