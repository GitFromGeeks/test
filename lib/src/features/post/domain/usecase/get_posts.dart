import 'package:dartz/dartz.dart';
import 'package:test/src/core/errors/failures.dart';
import 'package:test/src/features/post/data/model/post_model.dart';
import 'package:test/src/features/post/domain/repository/post_repository.dart';

class GetPosts {
  final PostRepository repository;

  GetPosts(this.repository);

  Future<Either<Failure, List<PostModel>?>?> call() async {
    return await repository.getPosts();
  }
}
