import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.height * 1,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Hello, Abdur Rehman',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                '13 items not completed',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          SizedBox.fromSize(
            size: const Size(100, 100),
            child: Icon(
              Icons.flutter_dash_rounded,
              color: Theme.of(context).iconTheme.color,
            ),
          )
        ],
      ),
    );
  }
}
