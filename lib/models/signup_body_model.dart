class SignUpBody {
  String name;
  String phone;
  String username;
  String password;
  SignUpBody({
    required this.name,
    required this.phone,
    required this.username,
    required this.password
  });


  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["username"] = username;
    data["phone"] = phone;
    data["password"] = password;
    return data;
  }
}