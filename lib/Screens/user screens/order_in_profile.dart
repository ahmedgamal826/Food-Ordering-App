import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/admin%20screens/finanicial_managmenet_screen.dart';
import 'package:food_ordering_app/widgets/user%20widgets/order_card_in_profile.dart';
import 'package:intl/intl.dart'; // Import FirebaseAuth

class OrderInProfileUser extends StatefulWidget {
  @override
  State<OrderInProfileUser> createState() => _OrderInProfileUserState();
}

class _OrderInProfileUserState extends State<OrderInProfileUser> {
  int orderCount = 0;

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: const Text(
          'My Orders',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('cartsUser')
                .where('userId', isEqualTo: userId)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              int orderCount = snapshot.data?.docs.length ?? 0;
              final badgeSize = orderCount > 9 ? 30.0 : 24.0;
              return Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart_rounded,
                      size: 35,
                    ),
                  ),
                  if (orderCount >= 0)
                    Positioned(
                      right: 0,
                      child: ClipOval(
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: BoxConstraints(
                            maxWidth: orderCount >= 1000 ? 50 : 30,
                            maxHeight: badgeSize,
                          ),
                          child: Center(
                            child: Text(
                              orderCount >= 1000 ? '999+' : '$orderCount',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: orderCount >= 1000 ? 10 : 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          )
        ],
      ),
      body: userId == null
          ? const Center(
              child: Text(
                'User not logged in.',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('cartsUser')
                  .where('userId', isEqualTo: userId) // Filter by userId
                  .orderBy('timestamp', descending: true) // Sort by timestamp
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                final orders = snapshot.data?.docs ?? [];

                if (orders.isEmpty) {
                  return const Center(
                    child: Text(
                      'No orders found.',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index].data() as Map<String, dynamic>;
                    final documentId = orders[index].id;

                    final items = (order['items'] as List<dynamic>?) ?? [];
                    final timestamp =
                        (order['timestamp'] as Timestamp?)?.toDate();
                    final formattedTime = timestamp != null
                        ? DateFormat('yyyy-MM-dd – hh:mm a')
                            .format(timestamp.toLocal())
                        : 'Unknown Time';

                    return OrderCardInProfile(
                      formattedTime: formattedTime,
                      items: items,
                    );
                  },
                );
              },
            ),
    );
  }
}
