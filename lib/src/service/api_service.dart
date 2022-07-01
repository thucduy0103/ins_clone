import 'package:dio/dio.dart';
import 'package:flutter_ig_clone/src/repository/model/post_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://62bdbbcac5ad14c110c59f58.mockapi.io/")
abstract class RestClient {
  factory RestClient(Dio dio) = _RestClient;

  @GET("/api/v1/posts")
  Future<List<Post>> getTasks();

  @POST("/api/v1/posts")
  Future<Post> createPost(@Body() Post post);
}
