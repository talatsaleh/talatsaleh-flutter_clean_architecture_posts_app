import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_posts_app/core/errors/exptiones.dart';
import 'package:flutter_clean_architecture_posts_app/core/utils/typedef.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/data/models/post_model.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<Post>> getAllPosts();

  Future<Unit> deletePost(String id);

  Future<Unit> updatePost(PostModel post);

  Future<Unit> addPost(Post post);
}

const url = 'https://jsonplaceholder.org';

class PostRemoteDataSourceImp implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImp({required this.client});

  @override
  Future<List<Post>> getAllPosts() async {
    final response = await client.get(Uri.parse('$url/posts'),
        headers: {"content-Type": "application/json"});
    if (response.statusCode == 200) {
      List decodedJson = json.decode(response.body) as List;
      final List<PostModel> listOfPostModels = decodedJson
          .map<PostModel>((jsonPost) => PostModel.fromJson(jsonPost))
          .toList();
      return listOfPostModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(Post post) async {
    final body = {
      'title': post.title,
      'body': post.body,
    };
    final response = await client.post(
        Uri.parse(
          '$url/posts/',
        ),
        body: body);
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(String id) async {
    final response = await client.delete(
      Uri.parse('$url/posts/${id.toString()}'),
      headers: {"content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final postId = post.id.toString();
    final body = {
      'title': post.title,
      'body': post.body,
    };
    final response = await client.patch(
      Uri.parse('$url/posts/$postId'),
      body: body,
    );
    if(response.statusCode == 200){
      return Future.value(unit);
    }else{
      throw ServerException();
    }
  }
}
