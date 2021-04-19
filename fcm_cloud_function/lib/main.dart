import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:rxdart/rxdart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Ubicación actual'),
              onTap: () async {
                final currentLocation =
                    await LocationManager.Location().getLocation();
                final currentLatLng =
                    LatLng(currentLocation.latitude, currentLocation.longitude);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CustomMap(
                      markerId: '_currentUbication',
                      center: currentLatLng,
                    ),
                  ),
                );
              },
            ),
            ListTile(
                leading: Icon(Icons.add_location),
                title: Text('Añadir dirección'),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => LocationSearch()))),
          ],
        ),
      ),
    );
  }
}

const kGoogleApiKey = "AIzaSyADAXKQsQ2pIjttejID3HqapqLdY7v2_50";
// to get places detail (lat/lng)
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class LocationSearch extends PlacesAutocompleteWidget {
  LocationSearch()
      : super(
          apiKey: kGoogleApiKey,
          //sessionToken: Uuid().generateV4(), //TODO: colocar uid del usuario
          language: "es",
          components: [Component(Component.country, "ec")],
        );

  @override
  LocationSearchState createState() => LocationSearchState();
}

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
   return Row(
     children:[
       Icon(Icons.search),
       AppBarPlacesAutoCompleteTextField(),
     ],
   );
  }


}


class LocationSearchState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.search),
          title: AppBarPlacesAutoCompleteTextField(),
        ),
        body: Column(
          children: <Widget>[
            //CustomAppBar(), //AppBarPlacesAutoCompleteTextField(),
            Divider(),
            Expanded(
              child: Container(
                color: Theme.of(context).canvasColor,
                child: PlacesAutocompleteResult(
                  onTap: (p) async {
                    print(p);
                    PlacesDetailsResponse detail =
                        await _places.getDetailsByPlaceId(p.placeId);
                    final lat = detail.result.geometry.location.lat;
                    final lng = detail.result.geometry.location.lng;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CustomMap(
                          center: LatLng(lat, lng),
                          markerId: p.placeId,
                        ),
                      ),
                    );
                  },
                  logo: Row(
                    children: [
                      Text('Inrese una dirección'),
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomSheet: FlatButton(
          child: Text('O ingrese manualmente'),
          onPressed: () async {
            final currentLocation =
                await LocationManager.Location().getLocation();
            final currentLatLng =
                LatLng(currentLocation.latitude, currentLocation.longitude);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CustomMap(
                  markerId: '_currentUbication',
                  center: currentLatLng,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    // searchScaffoldKey.currentState.showSnackBar(
    //   SnackBar(content: Text(response.errorMessage)),
    // );
    print('[DEBUG] ${response.errorMessage}');
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {
      // searchScaffoldKey.currentState.showSnackBar(
      //   SnackBar(content: Text("Got answer")),
      // );
      print('got answer');
    }
  }
}

///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
//

class CustomMap extends StatefulWidget {
  final LatLng center;
  final MarkerId _markerId;

  CustomMap({
    Key key,
    this.center,
    String markerId,
  })  : _markerId = MarkerId(markerId ?? '_currentMarkId'),
        super(key: key);

  @override
  _CustomMapState createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  TextEditingController _streetController;
  TextEditingController _buildController;
  GoogleMapController _mapController;
  Set<Marker> _markers;
  Address _currentAddressMarker;

  @override
  void initState() {
    _markers = Set.from([
      Marker(markerId: widget._markerId, position: widget.center),
    ]);
    _streetController = TextEditingController(text: '');
    _buildController = TextEditingController(text: '');
    super.initState();
  }

  updateAdress() async {
    final currentCoordinates = Coordinates(
      _markers.first.position.latitude,
      _markers.first.position.longitude,
    );
    final adresses =
        await Geocoder.local.findAddressesFromCoordinates(currentCoordinates);
    // for (var item in adresses) {
    //   print('[DEBUG]- \n\t${item.coordinates}\n\t$currentCoordinates');
    // }
    setState(() {
      // _mapController.
      _currentAddressMarker = adresses.first;
      _streetController.text = _currentAddressMarker.thoroughfare ??
          '' + _currentAddressMarker.featureName ??
          '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: buildGoogleMap(),
            ),
            Expanded(flex: 1, child: buildData()),
          ],
        ),
      ),
    );
  }

  buildData() {
    return Column(
      children: [
        TextField(
          controller: _streetController,
          decoration: InputDecoration(prefixIcon: Icon(Icons.location_on)),
        ),
        TextField(
          controller: _buildController,
          decoration: InputDecoration(prefixIcon: Icon(Icons.home)),
        ),
        RaisedButton(
          child: Text('Confirmar ubicación'),
          onPressed: () {},
        )
      ],
    );
  }

  buildGoogleMap() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      mapToolbarEnabled: true,
      padding: EdgeInsets.all(8),
      rotateGesturesEnabled: true,
      scrollGesturesEnabled: true,
      onTap: (position) async {
        _markers = Set.from([_markers.first.copyWith(positionParam: position)]);
        //TODO: pilaaas

        updateAdress();

        // final adresses = await Geocoder.local.findAddressesFromCoordinates(
        //     Coordinates(position.latitude, position.longitude));

        // print('[DEBUG] ${adresses.first}');
        // final addressItem = adresses.first;
      },
      indoorViewEnabled: true,
      buildingsEnabled: true,
      initialCameraPosition: const CameraPosition(
        target: LatLng(0.0, 0.0),
      ),
      markers: _markers,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
    );
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    final center =
        widget.center == null ? await getCurrentLocation() : widget.center;
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: center == null ? LatLng(0, 0) : center, zoom: 15.0),
      ),
    );
    _mapController.showMarkerInfoWindow(widget._markerId);
    updateAdress();
  }

  getCurrentLocation() async {
    final currentLocation = await LocationManager.Location().getLocation();
    return LatLng(currentLocation.latitude, currentLocation.longitude);
  }
}

///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
//

class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
          apiKey: kGoogleApiKey,
          //sessionToken: Uuid().generateV4(),
          language: "es",
          components: [Component(Component.country, "ec")],
        );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
    final body = PlacesAutocompleteResult(
      onTap: (p) async {
        //displayPrediction(p, searchScaffoldKey.currentState);
        PlacesDetailsResponse detail =
            await _places.getDetailsByPlaceId(p.placeId);
        final lat = detail.result.geometry.location.lat;
        final lng = detail.result.geometry.location.lng;

        print(p);
      },
      logo: Row(
        children: [FlutterLogo()],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
    return Scaffold(appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    // searchScaffoldKey.currentState.showSnackBar(
    //   SnackBar(content: Text(response.errorMessage)),
    // );
    print(response.errorMessage);
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {
      // searchScaffoldKey.currentState.showSnackBar(
      //   SnackBar(content: Text("Got answer")),
      // );
      print('got answer');
    }
  }
}

// import 'dart:async';

// import 'package:google_maps_webservice/places.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:flutter/material.dart';
// import 'dart:math';

// const kGoogleApiKey = "AIzaSyADAXKQsQ2pIjttejID3HqapqLdY7v2_50";
// // to get places detail (lat/lng)
// GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

// main() {
//   runApp(MiAplicacion());
// }

// final customTheme = ThemeData(
//   primarySwatch: Colors.blue,
//   brightness: Brightness.dark,
//   accentColor: Colors.redAccent,
//   inputDecorationTheme: InputDecorationTheme(
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(4.00)),
//     ),
//     contentPadding: EdgeInsets.symmetric(
//       vertical: 12.50,
//       horizontal: 10.00,
//     ),
//   ),
// );

// class RoutesWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         title: "My App",
//         // theme: customTheme,
//         routes: {
//           "/": (_) => MyApp(),
//           "/search": (_) => CustomSearchScaffold(),
//         },
//       );
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// final homeScaffoldKey = GlobalKey<ScaffoldState>();
// final searchScaffoldKey = GlobalKey<ScaffoldState>();

// class _MyAppState extends State<MyApp> {
//   Mode _mode = Mode.overlay;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: homeScaffoldKey,
//       appBar: AppBar(
//         title: Text("My App"),
//       ),
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           _buildDropdownMenu(),
//           RaisedButton(
//             onPressed: _handlePressButton,
//             child: Text("Search places"),
//           ),
//           RaisedButton(
//             child: Text("Custom"),
//             onPressed: () {
//               Navigator.of(context).pushNamed("/search");
//             },
//           ),
//         ],
//       )),
//     );
//   }

//   Widget _buildDropdownMenu() => DropdownButton(
//         value: _mode,
//         items: <DropdownMenuItem<Mode>>[
//           DropdownMenuItem<Mode>(
//             child: Text("Overlay"),
//             value: Mode.overlay,
//           ),
//           DropdownMenuItem<Mode>(
//             child: Text("Fullscreen"),
//             value: Mode.fullscreen,
//           ),
//         ],
//         onChanged: (m) {
//           setState(() {
//             _mode = m;
//           });
//         },
//       );

//   void onError(PlacesAutocompleteResponse response) {
//     homeScaffoldKey.currentState.showSnackBar(
//       SnackBar(content: Text(response.errorMessage)),
//     );
//   }

//   Future<void> _handlePressButton() async {
//     // show input autocomplete with selected mode
//     // then get the Prediction selected
//     Prediction p = await PlacesAutocomplete.show(
//       context: context,
//       apiKey: kGoogleApiKey,
//       onError: onError,
//       // mode: _mode,
//       language: "es",
//       components: [Component(Component.country, "ec")],
//     );

//     displayPrediction(p, homeScaffoldKey.currentState);
//   }
// }

// Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
//   if (p != null) {
//     // get detail (lat/lng)
//     PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
//     final lat = detail.result.geometry.location.lat;
//     final lng = detail.result.geometry.location.lng;

//     scaffold.showSnackBar(
//       SnackBar(content: Text("${p.description} - $lat/$lng")),
//     );
//   }
// }

// // custom scaffold that handle search
// // basically your widget need to extends [GooglePlacesAutocompleteWidget]
// // and your state [GooglePlacesAutocompleteState]
// class CustomSearchScaffold extends PlacesAutocompleteWidget {
//   CustomSearchScaffold()
//       : super(
//           apiKey: kGoogleApiKey,
//           sessionToken: Uuid().generateV4(),
//           language: "es",
//           components: [Component(Component.country, "ec")],
//         );

//   @override
//   _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
// }

// class _CustomSearchScaffoldState extends PlacesAutocompleteState {
//   @override
//   Widget build(BuildContext context) {
//     final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
//     final body = PlacesAutocompleteResult(
//       onTap: (p) {
//         displayPrediction(p, searchScaffoldKey.currentState);
//       },
//       logo: Row(
//         children: [FlutterLogo()],
//         mainAxisAlignment: MainAxisAlignment.center,
//       ),
//     );
//     return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
//   }

//   @override
//   void onResponseError(PlacesAutocompleteResponse response) {
//     super.onResponseError(response);
//     searchScaffoldKey.currentState.showSnackBar(
//       SnackBar(content: Text(response.errorMessage)),
//     );
//   }

//   @override
//   void onResponse(PlacesAutocompleteResponse response) {
//     super.onResponse(response);
//     if (response != null && response.predictions.isNotEmpty) {
//       searchScaffoldKey.currentState.showSnackBar(
//         SnackBar(content: Text("Got answer")),
//       );
//     }
//   }
// }

// class Uuid {
//   final Random _random = Random();

//   String generateV4() {
//     // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
//     final int special = 8 + _random.nextInt(4);

//     return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
//         '${_bitsDigits(16, 4)}-'
//         '4${_bitsDigits(12, 3)}-'
//         '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
//         '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
//   }

//   String _bitsDigits(int bitCount, int digitCount) =>
//       _printDigits(_generateBits(bitCount), digitCount);

//   int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

//   String _printDigits(int value, int count) =>
//       value.toRadixString(16).padLeft(count, '0');
// }
// import 'dart:async';
// import 'dart:io';

// import 'package:fcm_cloud_function/search_directions.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   MyApp({Key key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   final pushProvider = PushNotificationsManager();
//   //   pushProvider.init();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Material App',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Material App Bar'),
//         ),
//         body: SearchDirections(),
//       ),
//     );
//   }
// }

// class PushNotificationsManager {
//   PushNotificationsManager._();

//   factory PushNotificationsManager() => _instance;

//   static final PushNotificationsManager _instance =
//       PushNotificationsManager._();

//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   bool _initialized = false;

//   Future<void> init() async {
//     String token = await _firebaseMessaging.getToken();
//     print("[DEBUG] FirebaseMessaging token: $token");
//     if (!_initialized) {
//       if (Platform.isIOS) {
//         _firebaseMessaging.requestNotificationPermissions();
//       }
//       _firebaseMessaging.configure(onResume: (map) {
//         print('[DEBUG]: (onResume) map: ${map.toString()}');
//         return;
//       }, onBackgroundMessage: (map) {
//         print('[DEBUG]: (onBackgroundMessage) map: ${map.toString()}');
//         return;
//       }, onLaunch: (map) {
//         print('[DEBUG]: (onLaunch) map: ${map.toString()}');
//         return;
//       }, onMessage: (map) {
//         print('[DEBUG]: (onMessage) map: ${map.toString()}');
//         return;
//       });
//       _initialized = true;
//     }
//   }
// }
