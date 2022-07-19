import 'package:flutter/material.dart';
import 'package:task2/widgets/grid_tile.dart';

import '../widgets/title.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.playlist_add_check,
            color: Theme.of(context).iconTheme.color,
          ),
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
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.70,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 75 / 100,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return MyGridTile(
                    index: index,
                    title: "Work",
                    tasks: "5",
                  );
                },
                itemCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
