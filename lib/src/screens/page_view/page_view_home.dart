import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../repository/model/post_model.dart';
import '../../service/api_service.dart';

class PageViewHome extends StatefulWidget {
  const PageViewHome({Key? key}) : super(key: key);

  @override
  _PageViewHomeState createState() => _PageViewHomeState();
}

class _PageViewHomeState extends State<PageViewHome> {
  late Future<List<Post>> futurePosts;

  FutureBuilder<List<Post>> _buildBody(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: futurePosts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<Post>? posts = snapshot.data;
          return _buildPosts(context, posts ?? []);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future<void> _pullRefresh() async {
    final client =
        RestClient(Dio(BaseOptions(contentType: "application/json")));
    List<Post> freshFuturePosts = await client.getTasks();
    setState(() {
      futurePosts = Future.value(freshFuturePosts);
    });
  }

  ListView _buildPosts(BuildContext context, List<Post> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        // print(" posts[index].avatar ${posts[index].avatar}");
        return Card(
          elevation: 4,
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: posts[index].avatar ??
                          "https://png.pngtree.com/png-vector/20190710/ourmid/pngtree-user-vector-avatar-png-image_1541962.jpg",
                      height: 40,
                      width: 40,
                      errorWidget: (context, a, s) {
                        return const Icon(Icons.account_circle);
                      },
                    ),
                    Text(posts[index].name ?? ""),
                  ],
                ),
                CachedNetworkImage(
                    imageUrl: posts[index].image ?? "",
                    width: MediaQuery.of(context).size.width,
                    errorWidget: (context, a, s) {
                      return const Icon(Icons.error);
                    }),
                Row(children: [
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(Icons.insert_comment_outlined)),
                  IconButton(
                      onPressed: () => {},
                      icon: const Icon(Icons.share_outlined))
                ]),
                // const Text("10 lượt thích"),
                Text(posts[index].content ?? "")
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    final client =
        RestClient(Dio(BaseOptions(contentType: "application/json")));
    // List<Post> freshFuturePosts = await client.getTasks();
    futurePosts = client.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 5, left: 5, top: 5),
      // child: _buildBody(context),
      child:
          RefreshIndicator(child: _buildBody(context), onRefresh: _pullRefresh),
    );
  }
}
