import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewsForm extends StatefulWidget {
  final int itemId;
  final String contentType;

  const ReviewsForm({super.key, required this.contentType, required this.itemId});

  @override
  State<ReviewsForm> createState() => _ReviewsFormState();
}

class _ReviewsFormState extends State<ReviewsForm> {
  int _selectedRating = 0;
  final TextEditingController _reviewController = TextEditingController();

  Future<void> _submitReview() async {
    var request = context.read<CookieRequest>();
    var url = 'http://10.0.2.2:8000/reviews/${widget.contentType}/${widget.itemId}/review_fnd_flutter';
    var response = await request.post(
      url,
      jsonEncode({
        'rating': _selectedRating,
        'ulasan': _reviewController.text,
        'content_type': widget.contentType,
        'object_id': widget.itemId,
      }),
    );

    if (response["success"]) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Review submitted successfully')),
        );
      }
      setState(() {
        _selectedRating = 0;
        _reviewController.clear();
      });
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to submit review')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Submit Review'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                icon: Icon(
                  index < _selectedRating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () {
                  setState(() {
                    _selectedRating = index + 1;
                  });
                },
              );
            }),
          ),
          TextField(
            controller: _reviewController,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Review',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            _submitReview();
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
