import 'package:gas/providers/location_provider.dart';

class UserModel {
  final String? fullName;
  String? userId;
  final String? email;
  final String? password;
  final String? phone;
  final bool? isProvider;
  final bool? isDriver;
  final bool? isAdmin;
  String? profilePic;
  String? transitId;
  final String? plateNumber;
  List<UserLocation>? locations;

  UserModel(
      {this.fullName,
      this.email,
      this.password,
      this.phone,
      this.isProvider,
      this.transitId,
      this.plateNumber,
      this.isAdmin = false,
      this.userId,
      this.locations,
      this.isDriver = false,
      this.profilePic});

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'phone': phone,
      'isProvider': false,
      'isDriver': isDriver,
      'userId': userId,
      'profilePic':
          'https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
      'transitId': transitId,
      'plateNumber': plateNumber,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      isProvider: json['isProvider'],
      userId: json['userId'],
      profilePic: json['profilePic'],
      transitId: json['transitId'],
      plateNumber: json['plateNumber'],
      isDriver: json['isDriver'],
      isAdmin: json['isAdmin'],
    );
  }
}
