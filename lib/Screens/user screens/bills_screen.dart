import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_ordering_app/widgets/user%20widgets/bills_card.dart';
import 'package:food_ordering_app/components/show_snack_bar.dart';
import 'package:intl/intl.dart';

class BillsScreen extends StatefulWidget {
  @override
  _BillsScreenState createState() => _BillsScreenState();
}

class _BillsScreenState extends State<BillsScreen> {
  final userId = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white, size: 25),
        centerTitle: true,
        title: const Text(
          'My Bills',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
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
              stream: _firestore
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
                      'No bills found.',
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

                    return BillsCard(
                      items: items,
                      formattedTime: formattedTime,
                      total: order['total'] ?? 0.0,
                      customerName: order['customerName'] ?? 'Unknown',
                      deliveryAddress: order['deliveryAddress'] ?? 'Unknown',
                      documentId: documentId,
                      onDelete: () {
                        _showDeleteConfirmationDialog(documentId);
                      },
                    );
                  },
                );
              },
            ),
    );
  }

  // Function to show a confirmation dialog before deletion
  void _showDeleteConfirmationDialog(String documentId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Delete Confirmation',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this bill?',
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    _deleteBill(documentId); // Call the delete function
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Function to delete the bill from Firestore
  Future<void> _deleteBill(String documentId) async {
    try {
      await _firestore.collection('cartsUser').doc(documentId).delete();

      customShowSnackBar(
          context: context, content: 'Bill Deleted Successfully');
    } catch (e) {
      customShowSnackBar(context: context, content: 'Error deleting bill: $e');
    }
  }
}
