// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';

import 'theme.dart';
import 'simple_example.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: panelTheme,
        title: 'Panels Demo',
        //home: SimpleExample(),
        home: BackdropScaffold(
          backLayer: _backLayer(),
          appBar: BackdropAppBar(
            actions: <Widget>[
              BackdropToggleButton(
                icon: AnimatedIcons.list_view,
              ),
            ],
          ),
          frontLayer: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                _tabBar(),
                Expanded(
                  child: _tabBarView(),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _backLayer() {
    return ListView.separated(
      itemBuilder: (_, index) => ListTile(
        title: Text('Item $index'),
      ),
      separatorBuilder: (_, __) => Divider(
        color: Colors.red,
      ),
      itemCount: 16,
    );
  }

  _tabBar() {
    return TabBar(
      labelColor: Colors.black87,
      tabs: [
        Tab(text: 'PAGE 1'),
        Tab(text: 'PAGE 2'),
      ],
    );
  }

  _tabBarView() {
    return TabBarView(
      children: [
        Center(
          child: Text('Content page 1'),
        ),
        Center(
          child: Text('Content page 2'),
        ),
      ],
    );
  }
}
/*
class TestProbe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Backdrop(
          frontLayer: _frontLayer(),
          backLayer: _backLayer(),
          frontPanelOpenHeight: 100,
        ),
      ),
    );
  }

  Widget _frontLayer() {
    return Container(
      color: Colors.red,
    );
  }

  _tabBar() {
    return TabBar(
      labelColor: Colors.black87,
      tabs: [
        Tab(text: 'PAGE 1'),
        Tab(text: 'PAGE 2'),
      ],
    );
  }

  _tabBarView() {
    return TabBarView(
      children: [
        Center(
          child: Text('Content page 1'),
        ),
        Center(
          child: Text('Content page 2'),
        ),
      ],
    );
  }
}*/
