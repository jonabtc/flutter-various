import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:wifi/wifi.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _createEnableWifiButton(context),
              _createConnectWifiButton(),
              _createPermissionPushNotifications()
            ],
          ),
        ),
      ),
    );
  }


  _createEnableWifiButton(BuildContext context)  {

    return FlatButton(
      child: Text('Activar wifi'),
      onPressed: (){
        
        Connectivity().checkConnectivity().then((value) {
          
          if(value == ConnectivityResult.mobile){
            debugPrint('Ey, no mobile data');
          }else{
            if(value == ConnectivityResult.wifi){
              debugPrint('Ey, you rock!');
            }else{
              debugPrint('Ey, check your connection to wifi!');
            }
          }
        });
        
      }
    );
  }

  _createConnectWifiButton(){

    return FlatButton(
      child: Text('Conectar red Wifi'),
      onPressed: (){
        Wifi.connection('testing-net', '123cuatro5');
      },
    );
  }

  _createPermissionPushNotifications(){

    return FlatButton(
      child: Text('Permitir notificaciones'),
      onPressed: (){

      }
    );
  }
}