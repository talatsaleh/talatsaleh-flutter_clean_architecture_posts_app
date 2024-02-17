import 'package:flutter/material.dart';

class TextFormFiledCust extends StatelessWidget {
  const TextFormFiledCust({
    super.key,
    required this.controller,
    required this.name,
  });

  final TextEditingController controller;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        minLines: name == 'Body'? 6:1,
        maxLines: name == 'Body'? 6:1,
        decoration: InputDecoration(
          hintText: name,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        validator: (value) => value!.isEmpty ? '$name cant be Empty.' : null,
      ),
    );
  }
}
