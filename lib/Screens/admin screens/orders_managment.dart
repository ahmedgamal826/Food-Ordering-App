// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:food_ordering_app/Screens/finanicial_managmenet_screen.dart';
// // import 'package:food_ordering_app/components/loading_dots.dart';
// // import 'package:food_ordering_app/widgets/custom_appbar_order_management.dart';
// // import 'package:food_ordering_app/widgets/order_management_card.dart';
// // import 'package:intl/intl.dart';

// // class OrdersManagment extends StatefulWidget {
// //   @override
// //   State<OrdersManagment> createState() => _OrdersManagmentState();
// // }

// // class _OrdersManagmentState extends State<OrdersManagment> {
// //   String? _pendingDeleteDocumentId;
// //   int _orderCount = 0; // Store the number of orders

// //   @override
// //   void initState() {
// //     super.initState();
// //     getOrderCount();
// //   }

// //   Future<void> getOrderCount() async {
// //     final snapshot =
// //         await FirebaseFirestore.instance.collection('cartsUser').get();
// //     setState(() {
// //       _orderCount = snapshot.docs.length;
// //     });
// //   }

// //   Future<String> getUserName(String userId) async {
// //     final userSnapshot = await FirebaseFirestore.instance
// //         .collection('user_app')
// //         .doc(userId)
// //         .get();
// //     return userSnapshot.data()?['name'] ?? 'Unknown User';
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     // Calculate badge size based on order count
// //     final badgeSize = _orderCount > 9 ? 30.0 : 24.0;

// //     return Scaffold(
// //       appBar: CustomAppbarOrderManagement(
// //         badgeSize: badgeSize,
// //         financialScreen: FinancialScreen(),
// //         orderCount: _orderCount,
// //       ),
// //       body: StreamBuilder(
// //         stream: FirebaseFirestore.instance
// //             .collection('cartsUser')
// //             .orderBy('timestamp', descending: true)
// //             .snapshots(),
// //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             return Center(child: LoadingDots());
// //           }

// //           if (snapshot.hasError) {
// //             return Center(
// //               child: Text(
// //                 'Error: ${snapshot.error}',
// //                 style:
// //                     const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
// //               ),
// //             );
// //           }

// //           final orders = snapshot.data?.docs ?? [];

// //           if (orders.isEmpty) {
// //             return const Center(
// //               child: Text(
// //                 'No orders found.',
// //                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
// //               ),
// //             );
// //           }

// //           return ListView.builder(
// //             physics: const BouncingScrollPhysics(),
// //             itemCount: orders.length,
// //             itemBuilder: (context, index) {
// //               final order = orders[index].data() as Map<String, dynamic>;
// //               final documentId = orders[index].id;
// //               final items = (order['items'] as List<dynamic>?) ?? [];
// //               final timestamp = (order['timestamp'] as Timestamp?)?.toDate();
// //               final formattedTime = timestamp != null
// //                   ? DateFormat('yyyy-MM-dd – hh:mm a').format(timestamp)
// //                   : 'Unknown Time';
// //               final userId = order['userId'] as String?;

// //               final total = order['total'];

// //               return FutureBuilder<String>(
// //                 future: getUserName(userId ?? ''),
// //                 builder: (context, userSnapshot) {
// //                   final userName = userSnapshot.data ?? '';

// //                   return OrderManagementCard(
// //                     documentId: documentId,
// //                     formattedTime: formattedTime,
// //                     getOrderCount: getOrderCount,
// //                     items: items,
// //                     order: order,
// //                     total: total,
// //                     userName: userName,
// //                     pendingDeleteDocumentId: _pendingDeleteDocumentId,
// //                   );
// //                 },
// //               );
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:food_ordering_app/Screens/finanicial_managmenet_screen.dart';
// import 'package:food_ordering_app/components/loading_dots.dart';
// import 'package:food_ordering_app/widgets/custom_appbar_order_management.dart';
// import 'package:food_ordering_app/widgets/order_management_card.dart';
// import 'package:intl/intl.dart';

// class OrdersManagment extends StatefulWidget {
//   @override
//   State<OrdersManagment> createState() => _OrdersManagmentState();
// }

// class _OrdersManagmentState extends State<OrdersManagment> {
//   String? _pendingDeleteDocumentId;
//   int _orderCount = 0;

//   @override
//   void initState() {
//     super.initState();
//     getOrderCount(); // Fetch the initial order count
//   }

//   // Method to fetch and update the order count
//   Future<void> getOrderCount() async {
//     final snapshot =
//         await FirebaseFirestore.instance.collection('cartsUser').get();
//     setState(() {
//       _orderCount =
//           snapshot.docs.length; // Update the count when the data changes
//     });
//   }

//   // Method to delete an order
//   Future<void> deleteOrder(String documentId) async {
//     await FirebaseFirestore.instance
//         .collection('cartsUser')
//         .doc(documentId)
//         .delete();
//     await getOrderCount(); // Refresh the count after deleting
//   }

//   Future<String> getUserName(String userId) async {
//     final userSnapshot = await FirebaseFirestore.instance
//         .collection('user_app')
//         .doc(userId)
//         .get();
//     return userSnapshot.data()?['name'] ?? 'Unknown User';
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Adjust badge size based on order count
//     final badgeSize = _orderCount > 9 ? 30.0 : 24.0;

//     return Scaffold(
//       appBar: CustomAppbarOrderManagement(
//         badgeSize: badgeSize,
//         financialScreen: FinancialScreen(),
//         orderCount: _orderCount,
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('cartsUser')
//             .orderBy('timestamp', descending: true)
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: LoadingDots());
//           }

//           if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 'Error: ${snapshot.error}',
//                 style:
//                     const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//               ),
//             );
//           }

//           final orders = snapshot.data?.docs ?? [];

//           if (orders.isEmpty) {
//             return const Center(
//               child: Text(
//                 'No orders found.',
//                 style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//               ),
//             );
//           }

//           return ListView.builder(
//             physics: const BouncingScrollPhysics(),
//             itemCount: orders.length,
//             itemBuilder: (context, index) {
//               final order = orders[index].data() as Map<String, dynamic>;
//               final documentId = orders[index].id;
//               final items = (order['items'] as List<dynamic>?) ?? [];
//               final timestamp = (order['timestamp'] as Timestamp?)?.toDate();
//               final formattedTime = timestamp != null
//                   ? DateFormat('yyyy-MM-dd – hh:mm a').format(timestamp)
//                   : 'Unknown Time';
//               final userId = order['userId'] as String?;

//               final total = order['total'];

//               return FutureBuilder<String>(
//                 future: getUserName(userId ?? ''),
//                 builder: (context, userSnapshot) {
//                   final userName = userSnapshot.data ?? '';

//                   return OrderManagementCard(
//                       documentId: documentId,
//                       formattedTime: formattedTime,
//                       getOrderCount:
//                           getOrderCount, // Pass the getOrderCount function
//                       items: items,
//                       order: order,
//                       total: total,
//                       userName: userName,
//                       pendingDeleteDocumentId: _pendingDeleteDocumentId,
//                       onDelete: getOrderCount // Handle deletion
//                       );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }

//   // Confirm delete dialog
//   void _confirmDelete(BuildContext context, String documentId) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Delete Order"),
//           content: Text("Are you sure you want to delete this order?"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text("Cancel"),
//             ),
//             TextButton(
//               onPressed: () async {
//                 Navigator.of(context).pop(); // Close the dialog
//                 await deleteOrder(
//                     documentId); // Delete the order and update count
//               },
//               child: Text("Delete"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/Screens/admin%20screens/finanicial_managmenet_screen.dart';
import 'package:food_ordering_app/components/loading_dots.dart';
import 'package:food_ordering_app/widgets/admin%20widgets/custom_appbar_order_management.dart';
import 'package:food_ordering_app/widgets/order_management_card.dart';
import 'package:intl/intl.dart';

class OrdersManagment extends StatefulWidget {
  @override
  State<OrdersManagment> createState() => _OrdersManagmentState();
}

class _OrdersManagmentState extends State<OrdersManagment> {
  String? _pendingDeleteDocumentId;
  int _orderCount = 0;

  @override
  void initState() {
    super.initState();
    getOrderCount(); // Fetch the initial order count
  }

  // Method to fetch and update the order count
  Future<void> getOrderCount() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('cartsUser').get();
    setState(() {
      _orderCount =
          snapshot.docs.length; // Update the count when the data changes
    });
  }

  // Method to delete an order
  Future<void> deleteOrder(String documentId) async {
    await FirebaseFirestore.instance
        .collection('cartsUser')
        .doc(documentId)
        .delete();
    // No need to call getOrderCount as the StreamBuilder will handle it
  }

  Future<String> getUserName(String userId) async {
    final userSnapshot = await FirebaseFirestore.instance
        .collection('user_app')
        .doc(userId)
        .get();
    return userSnapshot.data()?['name'] ?? 'Unknown User';
  }

  Future<String> getUserImage(String userId) async {
    final userSnapshot = await FirebaseFirestore.instance
        .collection('user_app')
        .doc(userId)
        .get();
    return userSnapshot.data()!['profile_picture'];
  }

  @override
  Widget build(BuildContext context) {
    // Adjust badge size based on order count
    final badgeSize = _orderCount > 9 ? 30.0 : 24.0;

    return Scaffold(
      appBar: CustomAppbarOrderManagement(
        badgeSize: badgeSize,
        financialScreen: FinancialScreen(),
        orderCount: _orderCount,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('cartsUser')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: LoadingDots());
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

          final orders = snapshot.data?.docs ?? [];

          if (orders.isEmpty) {
            return const Center(
              child: Text(
                'No orders found.',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
              final timestamp = (order['timestamp'] as Timestamp?)?.toDate();
              final formattedTime = timestamp != null
                  ? DateFormat('yyyy-MM-dd – hh:mm a').format(timestamp)
                  : 'Unknown Time';
              final userId = order['userId'] as String?;

              final total = order['total'];

              return FutureBuilder<String>(
                future: getUserImage(userId ?? ''),
                builder: (context, userSnapshot) {
                  final userImage = userSnapshot.data ?? '';

                  return FutureBuilder<String>(
                    future: getUserName(userId ?? ''),
                    builder: (context, userSnapshot) {
                      final userName = userSnapshot.data ?? '';

                      return OrderManagementCard(
                          userImage: userImage,
                          documentId: documentId,
                          formattedTime: formattedTime,
                          getOrderCount:
                              getOrderCount, // Pass the getOrderCount function
                          items: items,
                          order: order,
                          total: total,
                          userName: userName,
                          pendingDeleteDocumentId: _pendingDeleteDocumentId,
                          onDelete: getOrderCount // Handle deletion
                          );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
