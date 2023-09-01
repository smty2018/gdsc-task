import 'package:flutter/material.dart';
import '../Models/data_model.dart';
import 'package:gdsctask/components/search.dart';
import 'package:gdsctask/pages/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../pages/homepage.dart';

class FavScr extends StatelessWidget {
  final List<int> favlist;
  final List<Data> dataList;
  FavScr({required this.favlist, required this.dataList});

  @override
  Widget build(BuildContext context) {
    List<Data> favcon =
        dataList.where((data) => favlist.contains(data.id)).toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Favorites"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Set the initial index
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: favcon.length,
        itemBuilder: (context, index) {
          var favData = favcon[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventDetailPage(eventData: favData),
                ),
              );
            },
            child: Card(
              elevation: 4,
              margin: EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          favData.bannerImage ?? '',
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(favData.title ?? ''),
                    subtitle: Text(
                      "${favData.venueName ?? ''}, ${favData.venueCity ?? ''}, ${favData.venueCountry ?? ''}",
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        // Remove the event's ID from favlist
                        favlist.remove(favData.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("${favData.title} removed from favorites"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
