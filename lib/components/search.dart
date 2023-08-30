import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:gdsctask/pages/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Models/data_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Search extends StatefulWidget {
  final void Function(String) updateList;

  const Search({required this.updateList, Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.0),
          TextField(
            controller: _searchController,
            onChanged: (value) {
              widget.updateList(value);
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white38,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Colors.white38),
              ),
              hintText: "Search By Conferemce Name",
              prefixIcon: Icon(Icons.search),
              prefixIconColor: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
