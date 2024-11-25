class LoginApi {
  String? email;
  String? password;
  String? role;
  String? token;

  LoginApi({this.email, this.password, this.role, this.token});

  LoginApi.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    role = json['role'];
    token = json['token'];
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['role'] = role;
    data['token'] = token;
    return data;
  }
}
