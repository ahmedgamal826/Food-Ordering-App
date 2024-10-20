import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountManagement extends StatefulWidget {
  @override
  _AccountManagementState createState() => _AccountManagementState();
}

class _AccountManagementState extends State<AccountManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Text(''),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          'Account Management',
          style: TextStyle(
              fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('user_app')
            .where('isLoggedIn', isEqualTo: true) // Filter for logged-in users
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.orange));
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No logged-in users found.',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            );
          }

          final users = snapshot.data!.docs;

          // Sort users by loginTimestamp in descending order
          users.sort((a, b) {
            final aTimestamp = (a.data()
                as Map<String, dynamic>)['loginTimestamp'] as Timestamp?;
            final bTimestamp = (b.data()
                as Map<String, dynamic>)['loginTimestamp'] as Timestamp?;

            if (aTimestamp != null && bTimestamp != null) {
              return bTimestamp.compareTo(aTimestamp); // Most recent first
            } else if (aTimestamp != null) {
              return -1; // a comes before b
            } else if (bTimestamp != null) {
              return 1; // b comes before a
            } else {
              return 0; // They are equal
            }
          });

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index].data() as Map<String, dynamic>;

              final userImage = user['profile_picture'] as String? ?? '';
              final userName = user['name'] as String? ?? 'No Name';
              final userEmail = user['email'] as String? ?? 'No Email';
              final Timestamp? loginTimestamp = user['loginTimestamp'];

              String loginDate = loginTimestamp != null
                  ? DateFormat('yyyy-MM-dd hh:mm a')
                      .format(loginTimestamp.toDate())
                  : 'No Login Date';

              return Card(
                color: Colors.orange,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 4.0,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Column(
                    children: [
                      userImage.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                userImage,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.person,
                                    size: 80,
                                    color: Colors.white,
                                  );
                                },
                              ),
                            )
                          : const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.white,
                            ),
                      Text(
                        textAlign: TextAlign.center,
                        userName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Divider(
                        indent: 25,
                        endIndent: 25,
                        thickness: 2,
                        color: Colors.white,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        '$userEmail\nLogin Date: $loginDate',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
