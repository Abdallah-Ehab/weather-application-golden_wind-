import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/app_colors.dart';
import 'package:weather_app/core/constants/text_style.dart';
import 'package:weather_app/presentation/bloc/get_city_name_bloc/cubit/get_city_name_cubit.dart';
import 'package:weather_app/presentation/bloc/suggested_cities_bloc/cubit/suggested_cities_cubit.dart';
import 'package:weather_app/presentation/pages/searched_city_details.dart';
import 'package:weather_app/presentation/widgets/background.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SuggestedCitiesCubit()),
        BlocProvider(create: (context) => GetCityNameCubit()),
      ],
      child: Background(
        isNight:DateTime.now().hour < 6 || DateTime.now().hour > 16,
        
        screen: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const Text(
                    "Pick location",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Find the area or city that you want to know the detailed weather info at this time",
                    style: TextStyle(color: AppColors.white, fontSize: 15),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Flexible(child: _buildTextField(context)),
                      const SizedBox(width: 10),
                      _buildLocationIcon(context),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildSuggestedCitiesList(context),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    return BlocListener<GetCityNameCubit, GetCityNameState>(
      listener: (context, state) {
        if (state is GetCityNameSuccess) {
          final cityName = state.suggestedCities[0].name ?? '';
          searchController.text = cityName;

          // Manually trigger the suggested cities fetching when location is set
          context.read<SuggestedCitiesCubit>().getSuggestedCities(cityName);
        }
      },
      child: TextFormField(
        onChanged: (query) {
          context.read<SuggestedCitiesCubit>().getSuggestedCities(query);
        },
        controller: searchController,
        style: TextStyles.medium,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 25,
            color: AppColors.white,
          ),
          labelText: "Search",
          labelStyle: const TextStyle(fontSize: 20, color: Colors.white),
          fillColor: Colors.black.withOpacity(0.3),
          filled: true,
        ),
      ),
    );
  }

  Widget _buildLocationIcon(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<GetCityNameCubit>().getCityNameByPosition();
      },
      child: Container(
        height: 57,
        width: 57,
        // padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: BlocBuilder<GetCityNameCubit, GetCityNameState>(
          builder: (context, state) {
            if (state is GetCityNameLoading) {
              return Transform.scale(
                  scale: 0.3,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ));
            } else {
              return const Icon(
                Icons.location_pin,
                color: AppColors.white,
                size: 30,
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildSuggestedCitiesList(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SuggestedCitiesCubit, SuggestedCitiesState>(
        builder: (context, state) {
          if (state is SuggestedCitiesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuggestedCitiesSuccess) {
            if (state.suggestedCities == null ||
                state.suggestedCities!.isEmpty) {
              log('list is empty: ${state.suggestedCities}');
              return const SizedBox();
            } else {
              log('list contains: ${state.suggestedCities}');
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: state.suggestedCities!.length,
                itemBuilder: (context, index) {
                  final city = state.suggestedCities![index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              SearchedCityDetails(cityName: city.name ?? '',addcity: true,),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.white.withOpacity(0.1),
                      child: ListTile(
                        title: Text(
                          '${city.name}, ${city.country}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          } else if (state is SuggestedCitiesFailure) {
            return Center(child: Text(state.message!));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
