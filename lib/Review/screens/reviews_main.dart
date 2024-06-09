import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BaseTemplate extends StatefulWidget {
  @override
  _BaseTemplateState createState() => _BaseTemplateState();
}

class _BaseTemplateState extends State<BaseTemplate> {
  String selectedSortBy = 'reviews'; // Default sorting criteria
  List<Map<String, dynamic>> reviewsData = []; // Holds the reviews data

  @override
  void initState() {
    super.initState();
    fetchReviewsData(selectedSortBy); // Fetch reviews with default sorting
  }

  void fetchReviewsData(String sortBy) async {
    // Fetch reviews data from your backend API based on sorting criteria
    // Replace 'your_backend_url_here' with your actual backend URL
    var url = 'your_backend_url_here?sort_by=$sortBy';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        var jsonResponse = json.decode(response.body);
        reviewsData = List<Map<String, dynamic>>.from(jsonResponse);
      });
    } else {
      // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sort by: '),
                DropdownButton<String>(
                  value: selectedSortBy,
                  onChanged: (String newValue) {
                    setState(() {
                      selectedSortBy = newValue;
                    });
                    fetchReviewsData(selectedSortBy);
                  },
                  items: <String>['reviews', 'rating'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: reviewsData.length,
              itemBuilder: (context, index) {
                return ReviewCard(reviewsData[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Map<String, dynamic> item;

  ReviewCard(this.item);

  @override
  Widget build(BuildContext context) {
    // Implement your review card UI here
    return ListTile(
      title: Text(item['title']),
      subtitle: Text(item['description']),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BaseTemplate(),
  ));
}
