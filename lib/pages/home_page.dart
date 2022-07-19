import 'package:flutter/material.dart';
import 'package:task2/widgets/grid_tile.dart';

import '../widgets/title.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollcontroller = ScrollController();

  // ignore: non_constant_identifier_names
  bool scroll_visibility = true;
  late var _gridHeight;
  @override
  void didChangeDependencies() {
    _gridHeight = MediaQuery.of(context).size.height * 0.70;
    scrollcontroller.addListener(() {
      late bool flag;
      if (scrollcontroller.position.pixels > 0 ||
          scrollcontroller.position.pixels <
              scrollcontroller.position.maxScrollExtent) {
        flag = false;
      } else {
        flag = true;
      }
      setState(() {
        _gridHeight = (MediaQuery.of(context).size.height * 0.85);
        scroll_visibility = flag;
        print(scroll_visibility);
        print(scrollcontroller.position.pixels);
        print("dependency changed");
      });
    });
    super.didChangeDependencies();
  }

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                visible: scroll_visibility,
                child: Row(
                  children: [
                    const MyTitle(),
                    const SizedBox(
                      width: 25,
                    ),
                    Icon(
                      // Make it a button
                      Icons.hourglass_bottom_rounded,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _gridHeight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 80 / 100,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    controller: scrollcontroller,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
