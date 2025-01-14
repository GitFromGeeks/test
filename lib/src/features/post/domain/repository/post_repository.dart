import 'package:dartz/dartz.dart';
import 'package:test/src/core/errors/failures.dart';
import 'package:test/src/features/post/data/model/post_model.dart';

abstract class PostRepository {
  Future<Either<Failure, List<PostModel>?>>? getPosts();
}
