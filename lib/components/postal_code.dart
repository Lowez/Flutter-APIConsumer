// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostalCode extends StatefulWidget {
  const PostalCode({super.key});

  @override
  State<PostalCode> createState() => _PostalCodeState();
}

class _PostalCodeState extends State<PostalCode> {
  bool _gotAddress = false;
  String postalCode = "";
  var _address = [];
  TextEditingController _postalCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _setAddress() {
    _gotAddress = !_gotAddress;
  }

  void _searchPostalCode() async {
    postalCode = _postalCodeController.text;

    String url = "https://cep.awesomeapi.com.br/json/$postalCode";
    http.Response response = await http.get(
      Uri.parse(url),
    );

    Map<String, dynamic> retorno = jsonDecode(response.body);

    setState(() {
      _address = [retorno["state"].toString(), retorno["city"].toString()];
      _setAddress();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Image.network(
            "https://digitaismidias.com.br/apps/buscar-endereco-pelo-cep/cep.png",
            height: 93,
          ),
        ),
        Container(
          height: 60,
          width: 75,
          child: TextField(
            controller: _postalCodeController,
            keyboardType: TextInputType.number,
          )
        ),
        !_gotAddress ? 
        Padding(padding: EdgeInsets.all(0.0))
        : 
        Text("${_address[0]} - ${_address[1]}"),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
            child: Text(
              _gotAddress ? "Limpar" : "Atualizar Preço",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            onPressed: _searchPostalCode,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[600],
              padding: EdgeInsets.all(15.0)
            ),
          ),
        ),
      ],
    );
  }
}