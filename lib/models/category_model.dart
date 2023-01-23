class CategoryModel {
  bool? status;
  CategoryData? data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoryData.fromJson(json['data']);
  }
} //end class

class CategoryData {
  int? current_page;
  List<DataModel>? data = [];

  CategoryData.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data!.add(DataModel.fromJson(element));
    });
  } //end named constructor()
} //end class

class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  } //end named constructor()
} //end class
