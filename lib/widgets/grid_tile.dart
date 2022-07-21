import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyGridTile extends StatelessWidget {
  int index;
  final String title;
  final String tasks;
  MyGridTile({
    Key? key,
    required this.index,
    required this.title,
    required this.tasks,
  }) : super(key: key);

  List mycolors = [
    Colors.blueAccent,
    Colors.amberAccent,
    Colors.brown,
    Colors.cyanAccent,
    Colors.orangeAccent,
    Colors.greenAccent,
    Colors.indigoAccent,
    Colors.yellowAccent,
    Colors.limeAccent,
    Colors.pinkAccent,
    Colors.purpleAccent,
    Colors.redAccent,
    Colors.tealAccent
  ];

  final Random _random = Random();

  List icons = [
    Icons.work,
    Icons.person,
    Icons.health_and_safety_rounded,
    Icons.location_city,
    Icons.add,
  ];

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Card(
        elevation: 1.5,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor:
                    Colors.primaries[_random.nextInt(Colors.primaries.length)]
                        [_random.nextInt(13) * 100],
                maxRadius: 20,
                child: Icon(
                  icons[index < icons.length ? index : 0],
                  color:
                      Colors.primaries[_random.nextInt(Colors.primaries.length)]
                          [_random.nextInt(7) * 100],
                  size: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(title, style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(
              height: 8,
            ),
            Text("$tasks tasks", style: Theme.of(context).textTheme.labelLarge),
          ],
        ),
      ),
    );
  }
}
