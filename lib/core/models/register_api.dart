class RegisterApi {
  String? username;
  String? email;
  String? password;
  String? role;

  RegisterApi({
    this.username,
    this.email,
    this.password,
    this.role
  });

  RegisterApi.fromJson(Map<String, dynamic> json){
    username = json["username"];
    email = json['email'];
    password = json['password'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username; 
    data['email'] = email; 
    data['password'] = password; 
    data['role'] = role; 
    return data;
  }
}