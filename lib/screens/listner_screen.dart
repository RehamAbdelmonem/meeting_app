import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zoom_app/resources/firestor_methods.dart';

class ListnersScreen extends StatelessWidget {
  const ListnersScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreMethods().meetingsHistory,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return const Center(
            child: Text("No meeting history available."),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            var meetingData = snapshot.data.docs[index].data();
            var participants = (meetingData['participants'] as List<dynamic>?) ?? [];

            return ListTile(
              title: Text(
                'Meeting Name: ${meetingData['meetingName']}',style: const TextStyle(fontSize: 20)
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Joined on: ${DateFormat.yMMMMd().format(meetingData['createdAt'].toDate())}',
                  style: const TextStyle(fontSize: 17)),
                  const Text('Participants:',style: TextStyle(fontSize: 20),),
                  for (var participant in participants)
                    if (participant != null && participant is Map<String, dynamic>)
                      Text(' - ${participant['participantName']}'),
                ],
              ),
            );
          },
        );
      },
    );
  }
}