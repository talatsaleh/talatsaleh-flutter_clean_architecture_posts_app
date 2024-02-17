import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/core/utils/app_theme.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_posts/add_delete_posts_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/pages/postsPage.dart';
import 'injection_container.dart' as di;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostsBloc>(create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent()),),
        BlocProvider<AddDeletePostsBloc>(create: (_) => di.sl<AddDeletePostsBloc>(),),
      ],
      child: MaterialApp(
        theme: appTheme,
        title: 'Posts App',
        home: const PostsPage(),
      ),
    );
  }
}
