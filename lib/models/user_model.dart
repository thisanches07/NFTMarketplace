class UserModel {
  int id;
  String name;
  String username;
  String phone;

  UserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.phone
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      phone: json['phone']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "name": name,
      "username": username,
      "phone": phone
    };
  }
}