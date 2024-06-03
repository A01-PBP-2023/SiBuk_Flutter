// To parse this JSON data, do
//
//     final food = foodFromJson(jsonString);

import 'dart:convert';

List<Food> foodFromJson(String str) => List<Food>.from(json.decode(str).map((x) => Food.fromJson(x)));

String foodToJson(List<Food> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Food {
    Model model;
    int pk;
    Fields fields;

    Food({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Food.fromJson(Map<String, dynamic> json) => Food(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
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


enum Model {
    FOODS_FOOD
}

final modelValues = EnumValues({
    "foods.food": Model.FOODS_FOOD
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
