import 'package:flutter/material.dart';

class SavesCities extends StatelessWidget {
  const SavesCities({super.key});

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Card(
          color:const Color.fromARGB(255, 68, 123, 234),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Cairo\n11:00 pm",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "24°C",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Clear",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.bookmark_outline_rounded,
                            color: Colors.white))
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}