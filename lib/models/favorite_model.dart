class FavoriteModel {
  bool? status;
  String? message;

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  } //end namedConstructor()
} //end class
