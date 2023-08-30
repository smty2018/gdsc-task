import 'package:flutter/material.dart';
import 'package:gdsctask/pages/favourite.dart';
import '../Models/data_model.dart';
import 'package:gdsctask/components/search.dart';
import 'package:gdsctask/pages/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> favlist = [];
  List<Data> dataList = [];
  List<Data> filteredDataList = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final response =
        await http.get(Uri.parse("https://gdscdev.vercel.app/api"));
    if (response.statusCode == 200) {
      final dataModel = DataModel.fromJson(jsonDecode(response.body));
      setState(() {
        dataList = dataModel.content!.data!;
        filteredDataList = dataList;
      });
    }
  }

  void updateList(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredDataList = dataList;
      } else {
        filteredDataList = dataList
            .where((data) =>
                data.title!.toLowerCase().startsWith(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Nerd Network",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavScr(
                  favlist: favlist,
                  dataList: dataList,
                ),
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
      body: Column(
        children: [
          Search(
            updateList: updateList,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDataList.length,
              itemBuilder: (context, index) {
                var eventData = filteredDataList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EventDetailPage(eventData: eventData),
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
                                eventData.bannerImage ?? '',
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            eventData.title ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            " ${eventData.venueCity ?? ''}, ${eventData.venueCountry ?? ''}",
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              favlist.contains(eventData.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              setState(() {
                                if (favlist.contains(eventData.id)) {
                                  favlist.remove(eventData.id);
                                } else {
                                  favlist.add(eventData.id!);
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
