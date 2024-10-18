import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [Colors.black,Colors.purple,Colors.blue],begin: Alignment.bottomLeft,end: Alignment.topRight)
                      
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  );
  }
}