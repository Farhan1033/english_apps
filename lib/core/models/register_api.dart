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

  Map<String, dynamic> ToJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username; 
    data['email'] = this.email; 
    data['password'] = this.password; 
    data['role'] = this.role; 
    return data;
  }
}