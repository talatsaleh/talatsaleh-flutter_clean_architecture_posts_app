import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_posts/add_delete_posts_bloc.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/widgets/add_update_post_page/add_update_btn.dart';
import 'package:flutter_clean_architecture_posts_app/features/posts/presentation/widgets/add_update_post_page/text_form_filed_cust.dart';
import 'package:http/http.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key, required this.isUpdate, this.post});

  final bool isUpdate;
  final Post? post;

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _body = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdate && widget.post != null) {
      print('true');
      _title.text = widget.post!.title;
      _body.text = widget.post!.body;
    }
    super.initState();
  }

  void _addOrUpdateFunction() {
    final validate = _formKey.currentState!.validate();
    if (validate) {
      final newPost =
          Post(id: widget.post?.id, title: _title.text, body: _body.text);
      if (widget.isUpdate) {
        BlocProvider.of<AddDeletePostsBloc>(context)
            .add(UpdatePostEvent(post: newPost));
      } else {
        BlocProvider.of<AddDeletePostsBloc>(context)
            .add(AddPostEvent(post: newPost));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFiledCust(
              controller: _title,
              name: 'Title',
            ),
            TextFormFiledCust(
              controller: _body,
              name: 'Body',
            ),
            AddUpdateBtn(
              onPressed: _addOrUpdateFunction,
              isUpdate: widget.isUpdate,
            ),
          ],
        ));
  }
}
