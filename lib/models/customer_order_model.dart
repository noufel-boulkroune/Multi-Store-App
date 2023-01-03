import 'package:flutter/material.dart';

class CustomerOrderModel extends StatelessWidget {
  final dynamic order;
  CustomerOrderModel({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Container(
        constraints:
            const BoxConstraints(maxHeight: 80, maxWidth: double.infinity),
        child: Row(
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 80, maxWidth: 80),
              child: Image.network(order["orderImage"]),
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order["productName"],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$ ${order["orderPrice"].toStringAsFixed(2)}"),
                      Text("x ${order["orderQuantity"].toString()}")
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [const Text("See more .."), Text(order["deliveryStatus"])],
      ),
      children: [
        Container(
          // height: 230,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: order["deliveryStatus"] == "delivered"
                  ? Colors.amber.shade100
                  : Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name: ${order["customerName"]}",
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  "Phone: ${order["customerPhone"]}",
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  "Email Address: ${order["customerEmail"]}",
                  style: const TextStyle(fontSize: 15),
                ),
                Text(
                  "Address: ${order["customerAddress"]}",
                  style: const TextStyle(fontSize: 15),
                ),
                Row(
                  children: [
                    const Text(
                      "Payment Status: ",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      "${order["paymentStatus"]}",
                      style:
                          const TextStyle(fontSize: 15, color: Colors.purple),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Delivry Status: ",
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(
                      "${order["deliveryStatus"]}",
                      style: const TextStyle(fontSize: 15, color: Colors.green),
                    ),
                  ],
                ),
                order["deliveryStatus"] == "shipping"
                    ? Text(
                        "Estimated Delivery Date: ${order["deliveryDate"]}",
                        style: const TextStyle(fontSize: 15),
                      )
                    : const Text(""),
                order["orderReview"] == false &&
                        order["deliveryStatus"] == "delivered"
                    ? TextButton(
                        onPressed: () {}, child: const Text("Write Review"))
                    : const Text(""),
                order["orderReview"] == true &&
                        order["deliveryStatus"] == "delivered"
                    ? Row(
                        children: const [
                          Icon(
                            Icons.check,
                            color: Colors.lightBlueAccent,
                          ),
                          Text(
                            "Review Added",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.lightBlueAccent),
                          )
                        ],
                      )
                    : const Text(""),
              ],
            ),
          ),
        )
      ],
    );
  }
}
