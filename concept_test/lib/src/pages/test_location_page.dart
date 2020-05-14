import 'package:location_permissions/location_permissions.dart';
import 'package:flutter/material.dart';

class LocationPageO extends StatefulWidget {
  @override
  _LocationPageOState createState() => _LocationPageOState();
}

class _LocationPageOState extends State<LocationPageO> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              child: Text('Permission'),
              onPressed: () async {
                PermissionStatus permission = await LocationPermissions().requestPermissions();
                var locPermission = await LocationPermissions().checkPermissionStatus(level: LocationPermissionLevel.location);
                var locPermission_1 = await LocationPermissions().checkPermissionStatus(level: LocationPermissionLevel.locationAlways);
                var locPermission_2 = await LocationPermissions().checkPermissionStatus(level: LocationPermissionLevel.locationWhenInUse);


                debugPrint('Estado del permiso $permission');
                debugPrint('Nivel de permiso location $locPermission');
                debugPrint('Nivel de permiso locationAlways $locPermission_1');
                debugPrint('Nivel de permiso locationWhenInUse $locPermission_2');
                
              },
            ),
          ],
        ),
      ),
      
    );
  }
}