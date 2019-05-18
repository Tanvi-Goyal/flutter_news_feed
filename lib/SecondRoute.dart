import 'package:flutter/material.dart';

import 'BookmarkScreen.dart';
import 'Categories.dart';

class SecondRoute extends StatefulWidget {
  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("News"),
      ),
      body: new TabBarView(
        children: <Widget>[new CategoriesScreen(), new BookmarkScreen()],
        controller: tabController,
      ),
      bottomNavigationBar: new Material(
        color: Colors.lightBlueAccent,
        child: new TabBar(
          controller: tabController,
          tabs: <Widget>[
            new Tab(
              icon: new Icon(Icons.category),
            ),
            new Tab(
              icon: new Icon(Icons.bookmark),
            )
          ],
        ),
      ),
    );
  }
}
