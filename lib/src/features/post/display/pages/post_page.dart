import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/src/features/post/data/model/post_model.dart';
import 'package:test/src/features/post/display/providers/post_providers.dart';
import 'package:test/src/features/post/display/widgets/post_card.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostProvider>(context, listen: false).eitherFailureOrPost();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<PostModel>? posts = Provider.of<PostProvider>(context).post;
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              Provider.of<PostProvider>(context, listen: false)
                  .eitherFailureOrPost();
              setState(() {
                isLoading = false;
              });
            },
          ),
        ],
      ),
      body: (isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (posts != null)
              ? (posts.isEmpty)
                  ? Center(
                      child: Text("No Post Available"),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.only(top: 10),
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return PostCard(post: posts[index]);
                      })
              : Center(
                  child: Text("No Post Available"),
                ),
    );
  }
}
