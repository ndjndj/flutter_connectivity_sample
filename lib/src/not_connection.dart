import 'package:flutter/material.dart';

class NotConnection extends StatelessWidget {
  const NotConnection({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text("not connection"),
      content: SizedBox(
        width: 200,
        height: 200,
        child: Text("network error."),
      ),
    );
  }
}