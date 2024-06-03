// To parse this JSON data, do
//
//     final drink = drinkFromJson(jsonString);

import 'dart:convert';

List<Drink> drinkFromJson(String str) => List<Drink>.from(json.decode(str).map((x) => Drink.fromJson(x)));

String drinkToJson(List<Drink> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Drink {
    String model;
    int pk;
    Fields fields;

    Drink({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Drink.fromJson(Map<String, dynamic> json) => Drink(
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
