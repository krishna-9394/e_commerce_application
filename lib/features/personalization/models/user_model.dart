import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_application/utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName, lastName;
  final String userName, email;
  String phoneNumber, profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
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
    String userNameWithprefix = "cwt_$camelCaseUserName"; // Add cwt_ prefix
    return userNameWithprefix;
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
      );
  // convert model to JSON structure for String data in Firebase
  Map<String, dynamic> toJson() {
    return {
      "FirstName": firstName,
      "LastName": lastName,
      "UserName": userName,
      "Email": email,
      "PhoneNumber": phoneNumber,
      "ProfilePicture": profilePicture,
    };
  }

  // Factory method to create a UserModel from Firebae document Snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
          id: document.id,
          firstName: data["FirstName"] ?? "",
          lastName: data["lastName"] ?? "",
          userName: data["userName"] ?? "",
          email: data["email"] ?? "",
          phoneNumber: data["phoneNumber"] ?? "",
          profilePicture: data["profilePicture"] ?? "");
    }
    return empty();
  }
}
