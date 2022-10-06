class ChangeFavourites{
  bool status;
  String message;

  ChangeFavourites.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
  }
}