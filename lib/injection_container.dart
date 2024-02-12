import 'package:flutter_clean_architecture_posts_app/core/network/network_info.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/data/datasource/post_local_data_source.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/data/datasource/post_rempote_data_source.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/data/repositories/post_repository.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/repositories/post_repository.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/usecases/add_post.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/usecases/delete_post.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/usecases/get_all_posts.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/usecases/update_post.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_posts/add_delete_posts_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
////! Features - posts

// Bloc

  sl.registerFactory(
    () => PostsBloc(
      getAllPosts: sl(),
    ),
  );
  sl.registerFactory(
    () => AddDeletePostsBloc(
      sl(),
      sl(),
      sl(),
    ),
  );

// UseCases
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
// Repository
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImp(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfoImp: sl(),
    ),
  );
// DataSources
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImp(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImp(sl()));
////! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));
//! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
