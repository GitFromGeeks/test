import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:flutter/material.dart';
import 'package:test/src/core/errors/failures.dart';
import 'package:test/src/core/networkInfo/network_info.dart';
import 'package:test/src/features/post/data/dataSource/post_local_source.dart';
import 'package:test/src/features/post/data/dataSource/post_remote_source.dart';
import 'package:test/src/features/post/data/model/post_model.dart';
import 'package:test/src/features/post/data/repository/post_repository_impl.dart';

class PostProvider extends ChangeNotifier {
  List<PostModel>? post;
  Failure? failure;

  PostProvider({this.post, this.failure});

  void eitherFailureOrPost() {
    PostRepositoryImpl postRepositoryImpl = PostRepositoryImpl(
        postRemoteSource: PostRemoteSourceImpl(),
        postLocalSource: PostLocalSourceImpl(),
        networkInfo: NetworkInfoImpl(DataConnectionChecker()));

    final postOrFailure = postRepositoryImpl.getPosts();

    postOrFailure.then((value) {
      value.fold((l) {
        failure = l;
        post = null;
        notifyListeners();
      }, (r) {
        post = r;
        failure = null;
        notifyListeners();
      });
    });
  }
}
