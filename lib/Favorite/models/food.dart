// To parse this JSON data, do
//
//     final food = foodFromJson(jsonString);

import 'dart:convert';

List<Food> foodFromJson(String str) => List<Food>.from(json.decode(str).map((x) => Food.fromJson(x)));

String foodToJson(List<Food> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Food {
    String model;
    int pk;
    Fields fields;

    Food({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Food.fromJson(Map<String, dynamic> json) => Food(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String merchantArea;
    String merchantName;
    String category;
    String product;
    String description;

    Fields({
        required this.merchantArea,
        required this.merchantName,
        required this.category,
        required this.product,
        required this.description,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        merchantArea: json["merchant_area"],
        merchantName: json["merchant_name"],
        category: json["category"],
        product: json["product"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "merchant_area": merchantArea,
        "merchant_name": merchantName,
        "category": category,
        "product": product,
        "description": description,
    };
}
