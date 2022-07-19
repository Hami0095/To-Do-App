import 'package:flutter/material.dart';

import '../widgets/title.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:
              Text("To-Do", style: Theme.of(context).textTheme.headlineMedium),
        ),
        body: Column(
          children: [
            Row(
              children: [
                const MyTitle(),
                const SizedBox(
                  width: 25,
                ),
                Icon(
                  Icons.hourglass_bottom_rounded,
                  color: Theme.of(context).iconTheme.color,
                ),
              ],
            )
            // GridView.builder(
            //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //     maxCrossAxisExtent: 2,
            //   ),
            //   itemBuilder: (context, index) {
            //     return const GridTile(
            //       child: Center(child: Text('Work')),
            //     );
            //   },
            //   itemCount: 5,
            // ),
          ],
        ),
      ),
    );
  }
}
