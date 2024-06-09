import 'dart:convert';

List<Review> reviewFromJson(String str) =>
    List<Review>.from(json.decode(str).map((x) => Review.fromJson(x)));

String reviewToJson(List<Review> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Review {
  String model;
  int pk;
  Fields fields;

  Review({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
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
  double averageRating;
  double percentageRating;
  int numReviews;

  Fields({
    required this.averageRating,
    required this.percentageRating,
    required this.numReviews,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        averageRating: json["average_rating"].toDouble(),
        percentageRating: json["percentage_rating"].toDouble(),
        numReviews: json["num_reviews"],
      );

  Map<String, dynamic> toJson() => {
        "average_rating": averageRating,
        "percentage_rating": percentageRating,
        "num_reviews": numReviews,
      };
}
