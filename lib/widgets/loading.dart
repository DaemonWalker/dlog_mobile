import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loading(BuildContext context, AsyncSnapshot snapshot,
    Widget Function(BuildContext, AsyncSnapshot) widget) {
  if (snapshot.hasData == false) {
    return Text('这玩意挂了好像？');
  }
  if (snapshot.connectionState == ConnectionState.none) {
    return Text('还没发呢');
  } else if (snapshot.connectionState == ConnectionState.active) {
    return Text('active');
  } else if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(
      child: CircularProgressIndicator(),
    );
  } else if (snapshot.connectionState == ConnectionState.done) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
    return widget(context, snapshot);
  }
}
