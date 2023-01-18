class CategoriesModel
{
  bool? status;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String,dynamic> json)
  {
    status = json['status'];
    data = json['data'] != null ? CategoriesDataModel.fromJson(json['data']) : null;

  }

}

class CategoriesDataModel
{
  int? currentPage;
  List<DataModel>? data=[];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      //data = <DataModel>[];
      json['data'].forEach((element) {
        data!.add(DataModel.fromJson(element));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }


}
class DataModel {
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}

List<String> category =
[
  "Jackets, Jeans, Denim...",
  "Dress, T-Shirt, Treasures...","Clothing, Toys, Books...",
  "Necklaces, Chains, Earnings...",
  "Shoes, Sandals, ActiveWear"
];