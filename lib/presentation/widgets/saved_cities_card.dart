import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/bloc/saved_cities_bloc/cubit/saved_cities_cubit.dart';

// ignore: must_be_immutable
class SavedCitiesCard extends StatefulWidget {
   SavedCitiesCard({super.key,required this.cityName,
      required this.temp,
      required this.unitSymbol,
      required  this.desc,
      required  this.icon,
      required this.onTap});
  String cityName;
  num temp;
  String unitSymbol,desc,icon;
  Function() onTap;

  @override
  State<SavedCitiesCard> createState() => _SavedCitiesCardState();
}

class _SavedCitiesCardState extends State<SavedCitiesCard> {
  bool longPressed = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: InkWell(
        onLongPress: (){
          setState(() {
            longPressed = !longPressed;
          });
        },
        onTap: widget.onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        widget.cityName,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.temp.round()}${widget.unitSymbol}',
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Text(
                          widget.desc,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Image.asset(
                      "assets/images/${widget.icon}.png",
                      height: 60,
                      width: 60,
                    ),

                    longPressed ? IconButton(onPressed: (){
                      context.read<SavedCitiesCubit>().removeCity(widget.cityName);
                    }, icon: const Icon(Icons.cancel_outlined,color: Colors.white,)):Container()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}