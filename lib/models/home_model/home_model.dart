class HomeModel{
   bool? status;
   HomeDataModel? data;
  HomeModel.fromJson(Map<String,dynamic>json){
  status=json['status'];
  data=HomeDataModel.fromJson(json['data']);
}
}

class HomeDataModel{
  List<BannerModel>banners=[];
  List<ProductModel>products=[];
  HomeDataModel.fromJson(Map<String,dynamic>json)
  {
    json['banners'].forEach((e){
      banners.add(BannerModel.fromJson(e));
    });

    json['products'].forEach((e){
      products.add(ProductModel.fromJson(e));
    });

  }
}
class BannerModel{
  int? id;
  dynamic image;
      BannerModel.fromJson(Map<String,dynamic>json)
      {
        id=json['id'];
        image=json['image'];

  }
}
class ProductModel{
   int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  dynamic image;
  dynamic  name;
  dynamic description;
  bool? inFavorites;
  bool? inCart;

  ProductModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];
    description = json['description'];

  }
}

// class HomeModel {
//  late bool status;
//   late String message;
//    Data? data;
//   HomeModel.fromJson(Map<String, dynamic> json)
//   {
//     status = json['status'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
// }
//
// class Data {
//   List<Banners>? banners;
//   List<Products>? products;
//   String? ad;
//
//   Data({this.banners, this.products, this.ad});
//
//   Data.fromJson(Map<String,dynamic> json) {
//     if (json['banners'] != null) {
//       banners = [];
//       json['banners'].forEach((v) {
//         banners?.add(Banners.fromJson(v));
//       });
//     }
//     if (json['products'] != null) {
//       json['products'].forEach((v) {
//         products?.add(Products.fromJson(v));
//       });
//     }
//     ad = json['ad'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (banners != null) {
//       data['banners'] = banners?.map((v) => v.toJson()).toList();
//     }
//     if (products != null) {
//       data['products'] = products?.map((v) => v.toJson()).toList();
//     }
//     data['ad'] = ad;
//     return data;
//   }
// }
//
// class Banners {
//   int? id;
//   String? image;
//   Null category;
//   Null product;
//
//   Banners({this.id, this.image, this.category, this.product});
//
//   Banners.fromJson(Map<String, dynamic> json) {
//     id= json['id'];
//     image = json['image'];
//     category = json['category'];
//     product = json['product'];
//
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['image'] = image;
//     data['category'] = category;
//     data['product'] = product;
//     return data;
//   }
// }
//
// class Products {
//   int? id;
//   dynamic price;
//   dynamic oldPrice;
//   int? discount;
//   String? image;
//   String? name;
//   String? description;
//   List<String>? images;
//   bool? inFavorites;
//   bool? inCart;
//
//   Products(
//       {this.id,
//         this.price,
//         this.oldPrice,
//         this.discount,
//         this.image,
//         this.name,
//         this.description,
//         this.images,
//         this.inFavorites,
//         this.inCart});
//
//   Products.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//     images = json['images'].cast<String>();
//     inFavorites = json['in_favorites'];
//     inCart = json['in_cart'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['price'] = price;
//     data['old_price'] = oldPrice;
//     data['discount'] = discount;
//     data['image'] = image;
//     data['name'] = name;
//     data['description'] = description;
//     data['images'] = images;
//     data['in_favorites'] = inFavorites;
//     data['in_cart'] = inCart;
//     return data;
//   }
// }