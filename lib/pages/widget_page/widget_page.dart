import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:page_view/model/categories.dart';
import 'package:page_view/model/news_latest.dart';
import 'package:page_view/utils/data_utils.dart';

class WidgetPage extends StatefulWidget {
  const WidgetPage({Key key}) : super(key: key);
  @override
  _WidgetPageState createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabList = <Tab>[
    Tab(
      text: 'TabBar',
    ),
    Tab(text: 'ListView'),
    Tab(text: 'GridView'),
    Tab(text: 'Silver'),
    Tab(text: 'Animation'),
  ];

  Future<NewsLatest> newsLatest;
  TabController _tabController;
  void initState() {
    super.initState();
    newsLatest = DataUtils.getNewsLatest();
    _tabController = TabController(length: tabList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Color(0xff232540),

      appBar: AppBar(
          title: Text('基础组件'),
          backgroundColor: Color(0xff232540),
          elevation: 10,
          bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: tabList,
            indicatorColor: Colors.pinkAccent,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.zero,
            indicatorWeight: 1,
            labelColor: Colors.white,
          )),
      body: Center(
        child: FutureBuilder<NewsLatest>(
          future: newsLatest,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Image.network(
                      'http://img.kaiyanapp.com/eaded016cfcb90a695661e37f2913a6b.jpeg?imageMogr2/quality/60'),
                  Text("${snapshot.data.stories[0].title}"),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
//      body: TabBarView(
//        controller: _tabController,
//        children: tabList.map((Tab tab) {
//          final String label = tab.text.toLowerCase();
//          return Center(
//            child: Text(
//              'This is the $label tab',
//              style: const TextStyle(fontSize: 36),
//            ),
//          );
//        }).toList(),
//      ),
    );
  }
}
