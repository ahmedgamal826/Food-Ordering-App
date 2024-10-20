import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class getItemsCountOrder extends StatelessWidget {
  const getItemsCountOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('carts')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .snapshots(),
      builder: (context, cartSnapshot) {
        if (cartSnapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            'Loading...',
          ); // You can add a loading indicator here
        }

        if (cartSnapshot.hasError || !cartSnapshot.hasData) {
          return const SizedBox(); // Handle error or no data
        }

        // Check if the document exists and has data
        final cartData = cartSnapshot.data!.data() as Map<String, dynamic>?;

        // If cartData is null, handle it accordingly (e.g., return 0 items)
        if (cartData == null) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Stack(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_cart,
                    size: 35,
                    color: Colors.orange,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: ClipOval(
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        maxWidth: 30,
                        maxHeight: 24.0,
                      ),
                      child: const Center(
                        child: Text(
                          '0',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        final items = cartData['items'] as List<dynamic>? ?? [];
        final itemCount = items.length;

        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.shopping_cart,
                  size: 35,
                  color: Colors.orange,
                ),
              ),
              if (itemCount > 0) // Show the badge only if there are items
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
                        maxWidth: itemCount >= 1000 ? 50 : 30,
                        maxHeight: itemCount > 9 ? 30.0 : 24.0,
                      ),
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          itemCount >= 1000 ? '999+' : '$itemCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: itemCount >= 1000 ? 10 : 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
