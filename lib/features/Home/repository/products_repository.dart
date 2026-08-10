import 'dart:convert';

import 'package:cubit/const/api_data.dart';
import 'package:cubit/model/product_model.dart';
import 'package:http/http.dart'as http;

class ProductsRepository {



  Future<Productsmodel>getallproducts()async{
final response=await http.get(Uri.parse(ApiUrl.apiUrl));
  final data = jsonDecode(response.body);

if(response.statusCode==200){

    return Productsmodel.fromJson(data);
}
return Productsmodel.fromJson(data);


  }
}


