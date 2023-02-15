import 'package:flutter/material.dart';
class GeezNumbers{
  final int id;
  final String image_url;
  final String creation_date;

  GeezNumbers(this.id,this.image_url,this.creation_date);

  Map<String,dynamic> toJson(){
    return {
      "id":id,"image_url":image_url,"creation_date":creation_date
    };
  }
  factory GeezNumbers.fromJson(Map<String,dynamic> json){
    return GeezNumbers(json["id"],json["image_url"],json["creation_date"]);
  }
}