import 'package:meta/meta.dart';

class UserClass {
  String? uid;
  String? email;
  String? FullName;
  String? HomeAddress;
  String? SNI;
  String? questionId;
  int? markedQuestionOption;
  bool? hasVoted;

  UserClass(
      {this.uid,
      this.email,
      this.FullName,
      this.HomeAddress,
      this.SNI,
      this.questionId,
      this.markedQuestionOption,
      this.hasVoted});

  // receiving data from server
  factory UserClass.fromMap(map) {
    return UserClass(
        uid: map['uid'],
        email: map['email'],
        FullName: map['FullName'],
        HomeAddress: map['HomeAddress'],
        SNI: map['SNI'],
        hasVoted: map['hasVoted']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'FullName': FullName,
      'HomeAddress': HomeAddress,
      'SNI': SNI,
      'hasVoted': hasVoted,
    };
  }
}
