class SearchModel {
  bool? status;
 // Null? message;
  Data? data;

 // FavoritesModel({this.status, this.message, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    //message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['message'] = this.message;
  //   if (this.data != null) {
  //     data['data'] = this.data!.toJson();
  //   }
  //   return data;
  // }
}

class Data {
  int? currentPage;
  List<Product>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
 // Null? nextPageUrl;
  String? path;
  int? perPage;
  //Null? prevPageUrl;
  int? to;
  int? total;

  // Data(
  //     {this.currentPage,
  //       this.data,
  //       this.firstPageUrl,
  //       this.from,
  //       this.lastPage,
  //       this.lastPageUrl,
  //       this.nextPageUrl,
  //       this.path,
  //       this.perPage,
  //       this.prevPageUrl,
  //       this.to,
  //       this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
   // nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    //prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['current_page'] = this.currentPage;
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   data['first_page_url'] = this.firstPageUrl;
  //   data['from'] = this.from;
  //   data['last_page'] = this.lastPage;
  //   data['last_page_url'] = this.lastPageUrl;
  //   data['next_page_url'] = this.nextPageUrl;
  //   data['path'] = this.path;
  //   data['per_page'] = this.perPage;
  //   data['prev_page_url'] = this.prevPageUrl;
  //   data['to'] = this.to;
  //   data['total'] = this.total;
  //   return data;
  // }
}



class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  dynamic image;
  String? name;
  String? description;

  Product(
      {this.id,
        this.price,
        this.oldPrice,
        this.discount,
        this.image,
        this.name,
        this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['discount'] = discount;
    data['image'] = image;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
