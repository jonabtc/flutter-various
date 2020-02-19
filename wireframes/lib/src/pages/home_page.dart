import 'package:flutter/material.dart';
import 'package:wireframes/src/pages/establishment_frame.dart';

import 'package:wireframes/src/widget/drawer_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync:this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: DrawerWidget(),
        body: SafeArea(
          child: Column(
            children: [
              _createPointsBanner(),
              _otherHomeTab(),
              //_createHomeTab(),
             // _createTabBarView(),
            ],
          ),
        ),
      );

   
  }

  Widget _createPointsBanner() {
    int points = 456;
    String text = (points > 1) ? 'puntos' : 'punto';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      padding: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.black,
        width: 1.0,
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text('$points',
                  style:
                      TextStyle(fontSize: 51.0, fontWeight: FontWeight.bold)),
              Text(text,
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ],
          ),
          Column(children: [
            Text('acumular',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
            Text('puntos',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
          ]),
        ],
      ),
    );
  }

  Widget _otherHomeTab(){
    return DefaultTabController(
      length: 2,
      child: Expanded( child: Column(
        children: [
          TabBar(
        tabs: [
          Tab(text: 'Promociones'),
          Tab(text: 'Establecimientos'),
        ],
        labelColor: Colors.black,
      ),
      Expanded(
        child: _createTabBarView()
      ),
        ],
      )
      )
    );
  }
  Widget _createHomeTab() {
    return Container(        
      child: TabBar(
        tabs: [
          Tab(text: 'Promociones'),
          Tab(text: 'Establecimientos'),
        ],
        labelColor: Colors.black,
        labelStyle: TextStyle(fontSize: 14.0),
        indicator: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
        ),
        controller: _tabController,
      ),
    );
  }
  
  Widget _createTabBarView(){
    
    return TabBarView(
      children: [
        Text('pagina de promociones'),
        EstablishmentFrame()
      ],
     // controller: _tabController,
    );
  }

}
