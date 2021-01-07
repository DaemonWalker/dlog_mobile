import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget tagList(List<String> tags) {
  return Row(children: [
    ...tags.map(
      (e) => FlatButton(
        child: Text(e),
        onPressed: () => Navigator.of(conte),
      ),
    )
  ]);
}
