class City {
  String name;

  String country;

  int population;
  int timezone;

  City({required this.name,required this.country,required this.population,required this.timezone});


  factory City.fromjson(Map<String,dynamic> json){
    return City(
      name: json["name"],
      country: json["country"],
      population: json["population"],
      timezone: json["timezone"]
    );
  }


  
}