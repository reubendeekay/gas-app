class UserModel {
  final String? fullName;
  String? userId;
  final String? email;
  final String? password;
  final String? phone;
  final bool? isProvider;
  final String? profilePic;

  UserModel(
      {this.fullName,
      this.email,
      this.password,
      this.phone,
      this.isProvider,
      this.userId,
      this.profilePic});

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'phone': phone,
      'isProvider': false,
      'userId': userId,
      'profilePic':
          'https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png'
    };
  }

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
      isProvider: json['isProvider'] as bool,
      userId: json['userId'] as String,
      profilePic: json['profilePic'] as String,
    );
  }
}
