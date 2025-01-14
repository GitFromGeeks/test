import 'package:flutter/material.dart';
import 'package:test/src/features/post/data/model/post_model.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 220, 211, 211),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title:
              Text(post.title, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle:
              Text(post.body, style: TextStyle(fontWeight: FontWeight.w300)),
        ),
      ),
    );
  }
}
