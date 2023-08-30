import 'package:flutter/material.dart';
import 'package:gdsctask/Models/data_model.dart';
import 'package:gdsctask/components/share.dart';
import 'package:share/share.dart';

class EventDetailPage extends StatelessWidget {
  final Data eventData;

  EventDetailPage({required this.eventData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          eventData.title ?? '',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(eventData.bannerImage ?? ''),
            SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(eventData.organiserIcon ?? ''),
                  radius: 23,
                ),
                SizedBox(width: 8),
                Text(
                  "Organizer: ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  eventData.organiserName ?? '',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.description,
                      size: 16,
                      color: Colors.green,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  eventData.description ?? '',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Venue",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  "${eventData.venueName ?? ''}, ${eventData.venueCity ?? ''}, ${eventData.venueCountry ?? ''}",
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "Date and Time",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  eventData.dateTime ?? '',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
