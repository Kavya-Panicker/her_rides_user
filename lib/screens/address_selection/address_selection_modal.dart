import 'package:flutter/material.dart';
import 'available_rides_modal.dart';
class AddressSelectionModal extends StatefulWidget {
  @override
  _AddressSelectionModalState createState() => _AddressSelectionModalState();
}

class _AddressSelectionModalState extends State<AddressSelectionModal> {
  int selectedField = 0; // 0: From, 1: To
  String? fromAddress;
  String? toAddress;
  String fromQuery = '';
  String toQuery = '';
  final fromController = TextEditingController();
  final toController = TextEditingController();

  final List<Map<String, dynamic>> recentPlaces = [
    {
      'icon': Icons.location_on_outlined,
      'label': 'Office',
      'address': '2972 Westheimer Rd. Santa Ana, Illinois 85486',
      'distance': '2.7km',
    },
    {
      'icon': Icons.local_cafe_outlined,
      'label': 'Coffee shop',
      'address': '1901 Thornridge Cir. Shiloh, Hawaii 81063',
      'distance': '1.1km',
    },
    {
      'icon': Icons.shopping_bag_outlined,
      'label': 'Shopping center',
      'address': '4140 Parker Rd. Allentown, New Mexico 31134',
      'distance': '4.9km',
    },
    {
      'icon': Icons.shopping_cart_outlined,
      'label': 'Shopping mall',
      'address': '4140 Parker Rd. Allentown, New Mexico 31134',
      'distance': '4.0km',
    },
  ];

  List<Map<String, dynamic>> get filteredFromPlaces {
    if (fromQuery.isEmpty) return recentPlaces;
    return recentPlaces
        .where((place) => place['label'].toString().toLowerCase().contains(fromQuery.toLowerCase()) ||
            place['address'].toString().toLowerCase().contains(fromQuery.toLowerCase()))
        .toList();
  }

  List<Map<String, dynamic>> get filteredToPlaces {
    if (toQuery.isEmpty) return recentPlaces;
    return recentPlaces
        .where((place) => place['label'].toString().toLowerCase().contains(toQuery.toLowerCase()) ||
            place['address'].toString().toLowerCase().contains(toQuery.toLowerCase()))
        .toList();
  }

  void selectAddress(String address, {bool isFrom = false}) {
    setState(() {
      if (isFrom) {
        fromAddress = address;
        fromController.text = address;
        selectedField = 1;
      } else {
        toAddress = address;
        toController.text = address;
      }
    });
  }

  @override
  void dispose() {
    fromController.dispose();
    toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select address',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // From and To fields with search
              Column(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => selectedField = 0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedField == 0 ? Colors.purpleAccent : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[100],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.my_location, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: fromController,
                              enabled: selectedField == 0,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'From',
                              ),
                              onChanged: (val) {
                                setState(() {
                                  fromQuery = val;
                                });
                              },
                              onTap: () => setState(() => selectedField = 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => setState(() => selectedField = 1),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: selectedField == 1 ? Colors.purpleAccent : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[100],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: toController,
                              enabled: selectedField == 1,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'To',
                              ),
                              onChanged: (val) {
                                setState(() {
                                  toQuery = val;
                                });
                              },
                              onTap: () => setState(() => selectedField = 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              if (selectedField == 0) ...[
                // Current location option for 'From'
                ListTile(
                  leading: const Icon(Icons.my_location, color: Colors.pink),
                  title: const Text('Current location'),
                  subtitle: const Text('2972 Westheimer Rd. Santa Ana, Illinois 85486'),
                  onTap: () => selectAddress('Current location', isFrom: true),
                ),
                ...filteredFromPlaces.map((place) => ListTile(
                      leading: Icon(place['icon'], color: Colors.grey[700]),
                      title: Text(place['label']),
                      subtitle: Text(place['address']),
                      trailing: Text(place['distance']),
                      onTap: () => selectAddress(place['label'], isFrom: true),
                    )),
              ] else ...[
                ...filteredToPlaces.map((place) => ListTile(
                      leading: Icon(place['icon'], color: Colors.grey[700]),
                      title: Text(place['label']),
                      subtitle: Text(place['address']),
                      trailing: Text(place['distance']),
                      onTap: () => selectAddress(place['label'], isFrom: false),
                    )),
              ],
              const SizedBox(height: 18),
              if (fromAddress != null && toAddress != null)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.pop(context, {'from': fromAddress, 'to': toAddress});
                  },
                  child: const Text(
                    'Confirm Location',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
} 