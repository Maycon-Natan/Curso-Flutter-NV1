import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:elevatedbutton/models/post_model.dart';
import 'package:flutter/material.dart';

class PostsController {
  ValueNotifier<List<Post>> posts = ValueNotifier<List<Post>>([]);
  ValueNotifier<bool> inLoader = ValueNotifier<bool>(false);

  callAPI() async {
    var client = HttpClient();
    try {
      inLoader.value = true;
      var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
      var response = await http.get(url);
      var decodedResponse = jsonDecode(response.body) as List;
      posts.value = decodedResponse.map((e) => Post.fromJson(e)).toList();
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      client.close();
      inLoader.value = false;
    }
  }
}
