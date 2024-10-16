String degToDirection(int deg){
    int val=(deg/22.5+0.5).toInt();
    List<String> arr=["N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"];
    return arr[(val % 16)];

}