class UserModel{
  String? name;
  String? email;
  String? pic;
  String? password;
  String? id;

  UserModel({
     this.name,
     this.email,
     this.pic,
     this.password,
     this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'email': this.email,
      'pic': this.pic,
      'password': this.password,
      'id': this.id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      pic: map['pic'] as String,
      password: map['password'] as String,
      id: map['id'] as String,
    );
  }
}