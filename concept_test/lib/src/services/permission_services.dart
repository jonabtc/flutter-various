import 'package:location/location.dart';

class PermissionServices{


  static Future<bool> requestLocationPermission() 
                      async => await Location().requestPermission();

  static Future<bool> requestLocationService() 
                      async => await Location().requestService();

  static Future<bool> isLocationActived() 
                      async => await Location().serviceEnabled();

  static Future<bool> isLocationAllowed() 
                      async => await Location().hasPermission();
}