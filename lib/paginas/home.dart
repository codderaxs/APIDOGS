import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import 'detallePerro.dart';

//import 'detallepokemon.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List breeds = [];
  List images = [];
  @override
  Widget build(BuildContext context) {
    var ancho = MediaQuery.of(context).size.width;
    var alto = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              top: 30,
              right: 50,
              child: Image.asset(
                "assets/img/logo.png",
                width: 50,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              top: 40,
              left: 20,
              child: Text(
                "Dog API",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Positioned(
                top: 90,
                left: 85,
                child: Text("Aldana Aguilar Alexis Enrique")),
            Positioned(
                top: 110,
                left: 80,
                child: Text("Colorado Rivas Cecilia Elizabeth")),
            Positioned(
              top: 30,
              right: 50,
              child: Image.asset(
                "assets/img/logo.png",
                width: 50,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(
              top: 130,
              bottom: 0,
              width: ancho,
              child: Column(children: [
                breeds.length != 0
                    ? Expanded(
                        child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 1.4),
                        itemCount: breeds.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.greenAccent,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Stack(children: [
                                    Positioned(
                                        top: 10,
                                        left: 20,
                                        child: Text(
                                          breeds[index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: Colors.white),
                                        )),
                                    Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: CachedNetworkImage(
                                        imageUrl: images[index],
                                        height: 80,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    )
                                  ])),
                            ),
                            onTap: () {
                              //TODO: llamar pantalla
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DetallePerro(
                                          detPerro: images[index],
                                          idbreed: index)));
                            },
                          );
                        },
                      ))
                    : Center(
                        child: CircularProgressIndicator(),
                      )
              ]),
            ),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      datosRaza();
      datosImage();
    }
  }

  void datosRaza() {
    var url = Uri.https('dog.ceo', '/api/breeds/list/all');
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        Map userMap = jsonDecode(value.body);

        breeds = userMap['message'].entries.map((e) {
          return e.key;
        }).toList();
        setState(() {});
      }
    });
  }

  void datosImage() {
    var url = Uri.https('dog.ceo', 'api/breed/hound/images');
    http.get(url).then((value) {
      if (value.statusCode == 200) {
        Map userMap = jsonDecode(value.body);

        for (var element in userMap["message"]) {
          images.add(element);
        }

        setState(() {});
      }
    });
  }
}
