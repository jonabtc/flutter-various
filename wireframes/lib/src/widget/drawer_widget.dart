import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Drawer(      
        child: ListView(
          children: [
            _createListItem('Perfil'),
            _createListItem('Eventos'),
            _createListItem('Consumos Anteriores'),
            _createListItem('Notificaciones'),
            _createListItem('Legal'),
            _createListItem('Reportar un problema'),
            _createListItem('Datos de Contacto Zwippe'),
            _createListItem('Cerrar Sesión'),
          ],
        ),
      ),
    );
  }

  _createListItem(String texto){
    return Column(      
      children: <Widget>[
        ListTile(
          title: Text(texto, style: TextStyle(fontSize: 16.0)),
          onTap: (){},
        ),
        Divider(
          height: 0,
          ),
      ],
    );
    
  }
}