import 'package:test/src/core/network/network_service.dart';
import 'package:test/src/features/post/data/model/post_model.dart';

abstract class PostRemoteSource {
  Future<List<PostModel>?> getPosts();
}

class PostRemoteSourceImpl implements PostRemoteSource {
  @override
  Future<List<PostModel>?> getPosts() async {
    List<PostModel>? posts;
    try {
      final response = await NetworkService.get(
          'https://jsonplaceholder.typicode.com/posts');
      posts = (response as List).map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to load data');
    }
    return posts;
  }
}
