import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {
  final estiloTitulo = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estiloSubtitulo = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Container(
          width: double.infinity,

          child: Image(
            image: NetworkImage(
                'https://lh3.googleusercontent.com/-H6PacdskbPehw_P3NQvLvIix3PK3gNC82AZXhpFhYm5PVY26CqyHieUp_jifhmYY-FrcezAVQ=w640-h400-e365'),
                height: 200.0,
                fit: BoxFit.cover,
          ),
        ),
        _crearTitulo(),
        _crearAcciones(),
        _crearTexto(),
        _crearTexto(),
        _crearTexto(),
        _crearTexto(),
        _crearTexto(),
      ]),
    ));
  }

  Widget _crearTitulo() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Montañas ey río', style: estiloTitulo),
                    SizedBox(
                      height: 7.0,
                    ),
                    Text('Montañas de los Alpes', style: estiloSubtitulo),
                  ]),
            ),
            Icon(Icons.star, color: Colors.red, size: 30.0),
            Text('41', style: TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }

  Widget _crearAcciones() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _accion(Icons.call, 'CALL'),
        _accion(Icons.near_me, 'ROUTE'),
        _accion(Icons.share, 'Share'),
      ],
    );
  }

  Widget _accion(IconData icon, String texto) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 40.0),
        SizedBox(height: 5.0),
        Text(
          texto,
          style: TextStyle(fontSize: 15.0, color: Colors.blue),
        )
      ],
    );
  }

  Widget _crearTexto() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.0),
        child: Text(
          'Eu exercitation dolor cillum cupidatat ex magna nulla ipsum. Ea amet nulla deserunt commodo laboris quis deserunt cillum sint et incididunt. Incididunt velit et ipsum voluptate culpa excepteur mollit et amet. Fugiat labore in officia elit eiusmod eiusmod deserunt id sint laborum ut nulla. Tempor esse cupidatat sit aliqua.Nisi exercitation esse esse do nisi culpa. Ut officia qui eiusmod magna sit nisi anim voluptate occaecat. Nisi elit est magna commodo et irure anim ut est et laboris enim duis fugiat.',
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
