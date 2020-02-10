import 'package:concept_test/src/services/permission_services.dart';
import 'package:flutter/material.dart';

class LocationVerificationPage extends StatefulWidget {
  @override
  _LocationVerificationPageState createState() =>
      _LocationVerificationPageState();
}

class _LocationVerificationPageState extends State<LocationVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gettering Permission'),
      ),
      body: _createListView(),
    );
  }

  _createListView() {
    return FutureBuilder(
      future: _getListPermissions(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          debugPrint('snapshot: ${snapshot.data}');
          return ListView.builder(
              key: UniqueKey(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) =>
                  snapshot.data[index]);
        } else {
          return Container(color: Colors.redAccent);
        }
      },
    );
  }

  _cardActiveLocation() {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.location_off,
              color: Colors.blueGrey,
            ),
            title: Text('Turn On Location'),
            subtitle: Text(
                'For use this application, you must get turn on location service'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                child: Text('Why?'),
                onPressed: () {},
              ),
              FlatButton(
                child: Text('ACTIVATE'),
                onPressed: ()=>PermissionServices.requestLocationService().then((value){
                  
                  if(value){
                    setState(() {
                      
                    });
                    debugPrint('Remover elemento');
                  }else{
                    debugPrint('Say something');
                  }
                }),
              )
            ],
          )
        ],
      ),
    );
  }

  _cardRequestLocationPermission() {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.location_disabled,
              color: Colors.blueGrey,
            ),
            title: Text('Grant acces to Location'),
            subtitle: Text(
                'For use this application, you must grant premission to use location service'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                child: Text('Why?'),
                onPressed: () {},
              ),
              FlatButton(
                child: Text('ALLOW'),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }

  _cardRequestPushNotificationPermission() {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.notifications_active,
              color: Colors.blueGrey,
            ),
            title: Text('Grant acces to Push Notification'),
            subtitle: Text(
                'For a better experience, grant push Notification permission to this app'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                child: Text('Why?'),
                onPressed: () {},
              ),
              FlatButton(
                child: Text('DENNY'),
                onPressed: () {},
              ),
              FlatButton(
                child: Text('ALLOW'),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }

  Future<List<Card>> _getListPermissions() async {
    List<Card> listPermissionWidgets = [];

    bool isLocationActived = await PermissionServices.isLocationActived();
    bool isLocationAllowed = await PermissionServices.isLocationAllowed();

    if (!isLocationActived) {
      listPermissionWidgets.add(_cardActiveLocation());
    }

    if (!isLocationAllowed) {
      listPermissionWidgets.add(_cardRequestLocationPermission());
    }
    //PermissionServices.isLocationActived().then((value)=>value?listPermissionWidgets.add(_cardRequestPushNotificationPermission()):null);
    // debugPrint(
    //     'Va a retornar la lista con ${listPermissionWidgets.length} elemento(s)');
    return listPermissionWidgets;
  }
}
