class UserModelOne {
  String uid;
  String? userName;
  String? email;
  String? fullName;
  String? recentCycle;
  String? phoneNumber;

  UserModelOne(
      {
        required this.uid,
        this.userName,
        this.email,
        this.fullName,
        this.phoneNumber,
        this.recentCycle
      });
  // data from server
  factory UserModelOne.fromMap(map) {
    return UserModelOne(
      uid: map['uid'],
      userName: map['userName'],
      email: map['email'],
      fullName: map['fullName'],
      phoneNumber: map['phoneNumber'],
      recentCycle: map['recentCycle']
    );
  }
// sending data to server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'recentCycle': recentCycle
    };
  }
}