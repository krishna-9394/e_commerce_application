import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/utils/constants/enums.dart';
import 'package:e_commerce_application/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName, lastName;
  final String userName, email;
  String phoneNumber, profilePicture;
  final Role role;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.role,
  });

  // Helper function to get full name
  String get fullName => '$firstName $lastName';

  // Helper function to format Phone Number
  String get formattedPhoneNumber => TFormatter.formatPhoneNumber(phoneNumber);

  // static function to split full name into first and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

  // static function to generate the username from  the full name
  static String getUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUserName =
        "$firstName$lastName"; // combine the first name and last name
    String userNameWithPrefix = "cwt_$camelCaseUserName"; // Add cwt_ prefix
    return userNameWithPrefix;
  }

  // static function to create a empty user model
  static UserModel empty() => UserModel(
        id: "",
        firstName: "",
        lastName: "",
        userName: "",
        email: "",
        phoneNumber: "",
        profilePicture: "",
        role: Role.customer,
      );
  // convert model to JSON structure for String data in Firebase
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "FirstName": firstName,
      "LastName": lastName,
      "UserName": userName,
      "Email": email,
      "PhoneNumber": phoneNumber,
      "ProfilePicture": profilePicture,
      "Role": role.toString().split('.').last,
    };
  }

  // Factory method to create a UserModel from Firebase document Snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        firstName: data["FirstName"] ?? "",
        lastName: data["LastName"] ?? "",
        userName: data["UserName"] ?? "",
        email: data["Email"] ?? "",
        phoneNumber: data["PhoneNumber"] ?? "",
        profilePicture: data["ProfilePicture"] ?? "",
        role: _roleFromString(data["Role"] ?? "customer"),
      );
    }
    return empty();
  }

  // Create UserModel from Map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      userName: json['UserName'],
      email: json['Email'],
      phoneNumber: json['PhoneNumber'],
      profilePicture: json['ProfilePicture'],
      role: Role.values.firstWhere((e) => e.toString().split('.').last == json['Role']),
    );
  }

  static Role _roleFromString(String role) {
    switch (role) {
      case 'admin':
        return Role.admin;
      case 'shopkeeper':
        return Role.shopkeeper;
      case 'customer':
      default:
        return Role.customer;
    }
  }
}
