import 'package:flutter/material.dart';

class MyGridTile extends StatelessWidget {
  const MyGridTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Column(
        children: [
          SizedBox.expand(
            child: Row(
              children: [
                Text("tileTitle", style: Theme.of(context).textTheme.bodyLarge),
                Text("Tasks rem",
                    style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
