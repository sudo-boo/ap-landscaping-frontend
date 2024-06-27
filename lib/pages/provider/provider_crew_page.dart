import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../config.dart';
import '../../models/crewinfo.dart';
import 'provider_add_crew_page.dart';

class crewPage extends StatefulWidget {
  final token;
  final providerId;

  const crewPage({super.key, this.token, this.providerId});
  @override
  State<crewPage> createState() => _crewPageState();
}

class _crewPageState extends State<crewPage> {
  Future<List<crewInfo>> crewMembersList() async {
    final response = await http.get(
      Uri.parse(crewListByProvider),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${widget.token}',
      },
    );
    if (response.statusCode == 200) {
      final List<dynamic> crewJson = json.decode(response.body)['crews'];
      final List<crewInfo> crewMembers = crewJson.map((crewMember) {
        // print(crewMember['yearsofexperience']);
        return crewInfo(
            fullname: crewMember['yearsofexperience'] ?? '',
            username: crewMember['username'] ?? '',
            email: crewMember['email'] ?? '',
            mobilenumber: crewMember['mobilenumber'] ?? '',
            city: crewMember['address'] ?? '',
            expertise: crewMember['qualifications'] ?? '',
            id: crewMember['id']);
      }).toList();
      return crewMembers;
    } else {
      throw Exception('Failed to load provider orders');
    }
  }

  Future<void> deleteCrew(String crewId) async {
    try {
      final response = await http.delete(
        Uri.parse(crewDelete + crewId),
        headers: {
          'Authorization': '${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        print('Crew deleted successfully');
      } else if (response.statusCode == 404) {
        print('Crew not found');
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (error) {
      print('Error deleting crew: $error');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text(
            'Crew',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          leading: IconButton(
              icon: const Image(
                image: AssetImage('assets/images/backIcon.png'),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProviderAddCrewPage(
                        token: widget.token, providerId: widget.providerId),
                  ),
                );
              },
            ),
          ],
        ),
        body: FutureBuilder<List<crewInfo>>(
            future: crewMembersList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: const CircularProgressIndicator()
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text('No crew members found.');
              } else {
                final crewMembers = snapshot.data;
                return ListView.builder(
                    itemCount: crewMembers?.length,
                    itemBuilder: (context, index) {
                      final crewMember = crewMembers?[index];
                      return Padding(
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Card(
                          color: const Color.fromRGBO(255, 234, 234, 1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 8.0, 16.0, 8.0),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                        crewMember!.username,
                                        style: const TextStyle(
                                          color: Color(0xFF3E363F),
                                          fontSize:18,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              const Icon(Icons.email_rounded,
                                                  color: Color(0xFF3E363F)),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                crewMember.email,
                                                style: const TextStyle(
                                                  color: Color(0xFF3E363F),
                                                  fontSize: 14,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              const Icon(
                                                  Icons.location_on_rounded,
                                                  color: Color.fromRGBO(62, 54,
                                                      63, 1)), // Email icon
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                crewMember.city,
                                                style: const TextStyle(
                                                  color: Color(0xFF3E363F),
                                                  fontSize: 14,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              const Icon(Icons.call_rounded,
                                                  color: Color.fromRGBO(62, 54,
                                                      63, 1)), // Email icon
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                crewMember.mobilenumber,
                                                style: const TextStyle(
                                                  color: Color(0xFF3E363F),
                                                  fontSize: 14,
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            deleteCrew(crewMember.id);
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => crewPage(
                                                  token: widget.token,
                                                  providerId: widget.providerId,
                                                ),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFFA686FF),
                                          ),
                                          child: const Text(
                                            'Remove',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            }));
  }
}
