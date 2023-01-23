class UserLoginData {
  bool? status;
  String? message;
  UserData? data;

  // named constructor()
  UserLoginData.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    message = jsonData['message'];
    //-------------maybe cause error
    data =
        jsonData['data'] != null ? UserData.fromJson(jsonData['data']) : null;
  }
} //end class

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    name = jsonData['name'];
    email = jsonData['email'];
    phone = jsonData['phone'];
    image = jsonData['image'];
    points = jsonData['points'];
    credit = jsonData['credit'];
    token = jsonData['token'];
  }
} //end class
