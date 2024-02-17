import 'package:flutter/material.dart';

class AddUpdateBtn extends StatelessWidget {
  const AddUpdateBtn(
      {super.key, required this.onPressed, required this.isUpdate});

  final void Function() onPressed;
  final bool isUpdate;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      label: Text(isUpdate ? 'Update' : 'Add'),
      icon: Icon(
        isUpdate ? Icons.edit : Icons.add,
      ),
    );
  }
}
