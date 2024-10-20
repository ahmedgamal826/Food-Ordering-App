// import 'package:flutter/material.dart';

// class BillsCard extends StatelessWidget {
//   final String customerName;
//   final String deliveryAddress;
//   final String formattedTime;
//   final List<dynamic> items;
//   final double total;

//   const BillsCard({
//     Key? key,
//     required this.customerName,
//     required this.deliveryAddress,
//     required this.formattedTime,
//     required this.items,
//     required this.total,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.orange,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             Text(
//               'Order for $customerName',
//               style: const TextStyle(
//                 fontSize: 20,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Address: $deliveryAddress',
//               style: const TextStyle(
//                 fontSize: 18,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Order Time: $formattedTime',
//               style: const TextStyle(
//                 fontSize: 20,
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             ...items.map((item) {
//               final product = (item['product'] as Map<String, dynamic>?) ?? {};
//               final productName = product['name'] as String? ?? '';
//               final quantity = item['quantity'] as int? ?? 0;
//               final itemTotalPrice = item['totalPrice'] as double? ?? 0.0;

//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//                   child: ListTile(
//                     leading: Text(
//                       '$quantity',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     title: Text(
//                       productName,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     trailing: Text(
//                       '\$${itemTotalPrice.toStringAsFixed(2)}',
//                       style: const TextStyle(
//                         fontSize: 20,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }).toList(),
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 'Delivery Services: \$20',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Total: \$${total.toStringAsFixed(2)}',
//                   style: const TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:food_ordering_app/components/custom_dialog.dart';

class BillsCard extends StatelessWidget {
  final String customerName;
  final String deliveryAddress;
  final String formattedTime;
  final List<dynamic> items;
  final double total;
  final String documentId; // Added to identify the document
  final VoidCallback onDelete; // Callback function for delete action

  const BillsCard({
    Key? key,
    required this.customerName,
    required this.deliveryAddress,
    required this.formattedTime,
    required this.items,
    required this.total,
    required this.documentId, // Document ID to delete the specific bill
    required this.onDelete, // Callback for delete
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              'Order for $customerName',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Address: $deliveryAddress',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Order Time: $formattedTime',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...items.map((item) {
              final product = (item['product'] as Map<String, dynamic>?) ?? {};
              final productName = product['name'] as String? ?? '';
              final quantity = item['quantity'] as int? ?? 0;
              final itemTotalPrice = item['totalPrice'] as double? ?? 0.0;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text(
                      productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      '\$${itemTotalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Delivery Services: \$20',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total: \$${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  ),
                  onPressed: () {
                    onDelete();
                  }, // Call the delete function
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
