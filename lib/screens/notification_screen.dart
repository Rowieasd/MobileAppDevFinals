import 'package:flutter/material.dart';
import 'bottom_navbar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Order Confirmed',
      'message': 'Your order #12345 has been confirmed',
      'time': '2 hours ago',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'title': 'New Offer',
      'message': 'Get 20% off on electronics this week',
      'time': '4 hours ago',
      'icon': Icons.local_offer,
      'color': Colors.orange,
    },
    {
      'title': 'Delivery Update',
      'message': 'Your package is out for delivery',
      'time': '1 day ago',
      'icon': Icons.local_shipping,
      'color': Colors.blue,
    },
    {
      'title': 'Payment Received',
      'message': 'Payment for order #12346 received',
      'time': '2 days ago',
      'icon': Icons.card_giftcard,
      'color': Colors.purple,
    },
    {
      'title': 'Review Request',
      'message': 'Please review your recent purchase',
      'time': '3 days ago',
      'icon': Icons.star,
      'color': Colors.amber,
    },
  ];

  /// 🔥 Navigate back to BottomNavBar
  void _goToHome() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const BottomNavBar()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      /// 🔥 Android back button behavior
      onWillPop: () async {
        _goToHome();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          automaticallyImplyLeading: false, // ✅ removes back button
        ),
        backgroundColor: Colors.grey[50],

        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return _buildNotificationTile(notifications[index]);
          },
        ),
      ),
    );
  }

  Widget _buildNotificationTile(Map<String, dynamic> notification) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: notification['color'].withOpacity(0.2),
            child: Icon(notification['icon'], color: notification['color']),
          ),
          title: Text(
            notification['title'],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                notification['message'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 4),
              Text(
                notification['time'],
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.close, color: Colors.grey, size: 20),
            onPressed: () {
              setState(() {
                notifications.remove(notification);
              });
            },
          ),

          /// 🔥 UPDATED SNACKBAR (0.2 seconds)
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(notification['title']),
                duration: const Duration(milliseconds: 200), // ✅ 0.2 sec
              ),
            );
          },
        ),
      ),
    );
  }
}
