import 'dart:developer';

import 'package:test/src/core/sqflite/sqflite.dart';
import 'package:test/src/features/post/data/model/post_model.dart';

abstract class PostLocalSource {
  Future<List<PostModel>> getPosts();
  Future<void> cachePosts(List<PostModel> posts);
}

class PostLocalSourceImpl implements PostLocalSource {
  @override
  Future<List<PostModel>> getPosts() async {
    log(' :------------------------------->  get local post   <------------------------------:');
    List<PostModel> posts = [];
    SqfliteService instance = SqfliteService.instance;
    List<Map<String, Object?>> data = await instance.getAll('posts');
    posts = data.map((e) => PostModel.fromJson(e)).toList();
    return posts;
  }

  @override
  Future<void> cachePosts(List<PostModel> posts) async {
    log(' :------------------------------->  cache local post   <------------------------------:');
    SqfliteService instance = SqfliteService.instance;
    instance.clearTable("posts");
    await instance.insertAll('posts', posts.map((e) => e.toJson()).toList());
  }
}
