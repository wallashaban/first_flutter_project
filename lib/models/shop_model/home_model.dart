class HomeModel {
  bool? status;
  Data? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<Banners> banners = [];
  List<Products> products = [];

  Data.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(Banners.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(Products.fromJson(element));
    });
  }
}

class Banners {
  int? id;
  String? image;

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Products {
  int? id;

  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  bool? inFavourites;
  bool? inCart;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    price = json['price'];
    discount = json['discount'];
    name = json['name'];
    oldPrice = json['old_price'];
    description = json['description'];
    inFavourites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
