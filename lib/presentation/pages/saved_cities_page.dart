import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/presentation/bloc/saved_cities_bloc/cubit/saved_cities_cubit.dart';
import 'package:weather_app/presentation/bloc/temperature_unit_bloc/cubit/temperature_unit_cubit.dart';
import 'package:weather_app/presentation/pages/searched_city_details.dart';
import 'package:weather_app/presentation/widgets/background.dart';
import 'package:weather_app/presentation/widgets/saved_cities_card.dart';
import 'package:weather_app/presentation/widgets/undesmissible_saved_city_card.dart';

class SavedCitiesPage extends StatelessWidget {
  const SavedCitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      isNight: DateTime.now().hour < 6 || DateTime.now().hour > 16,
      screen: BlocProvider<SavedCitiesCubit>(
        create: (context) => SavedCitiesCubit()..getSavedCities(),
        child: BlocBuilder<SavedCitiesCubit, SavedCitiesState>(
            builder: (context, state) {
          if (state is SavedCitiesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SavedCitiesFailed) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is SavedCitiesSuccess) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const UndesmissibleSavedCityCard(),
                  SizedBox(
                    width: double.infinity,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: state.savedCities.length,
                      itemBuilder: (context, index) {
                        num temp = state.savedCities[index].temperature;
                        final cubit = context.read<TemperatureUnitCubit>();
                        final temperature = cubit.convertTemperature(temp);
                        final unitSymbol = cubit.getUnitSymbol();
                    
                        return SavedCitiesCard(
                            cityName: state.savedCities[index].cityName,
                            temp: temperature,
                            unitSymbol: unitSymbol,
                            desc: state.savedCities[index].weatherCondition,
                            icon: state.savedCities[index].icon,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => SearchedCityDetails(
                                          cityName:
                                              state.savedCities[index].cityName,addcity: false,)));
                            });
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text("unknown error"),
            );
          }
        }),
      ),
    );
  }
}
