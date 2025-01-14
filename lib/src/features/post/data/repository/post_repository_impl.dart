import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:test/src/core/errors/exceptions.dart';
import 'package:test/src/core/errors/failures.dart';
import 'package:test/src/core/networkInfo/network_info.dart';
import 'package:test/src/features/post/data/dataSource/post_local_source.dart';
import 'package:test/src/features/post/data/dataSource/post_remote_source.dart';
import 'package:test/src/features/post/data/model/post_model.dart';
import 'package:test/src/features/post/domain/repository/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteSource postRemoteSource;
  final PostLocalSource postLocalSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl(
      {required this.postRemoteSource,
      required this.postLocalSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PostModel>?>> getPosts() async {
    if (await networkInfo.isConnected!) {
      log("Internet Connected");
      try {
        final remotePosts = await postRemoteSource.getPosts();
        if (remotePosts != null) {
          postLocalSource.cachePosts(remotePosts);
        }
        return Right(remotePosts);
      } on ServerException {
        return Left(CacheFailure(errorMessage: "Error Remote Server"));
      }
    } else {
      log("Internet Not Connected");
      try {
        final localPosts = await postLocalSource.getPosts();
        return Right(localPosts);
      } on CacheException {
        return Left(CacheFailure(errorMessage: "Error Local Storage Cache"));
      }
    }
  }
}
