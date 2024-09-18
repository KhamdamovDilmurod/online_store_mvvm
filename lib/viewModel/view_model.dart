import 'dart:async';

import 'package:stacked/stacked.dart';

import '../api/api_servie.dart';
import '../model/product_model.dart';

class MainViewModel extends BaseViewModel{
  final api = ApiService();
  final StreamController<String> _errorStream = StreamController();


  Stream<String> get errorData {
    return _errorStream.stream;
  }

  StreamController<List<ProductModel>> _productsStream = StreamController();

  Stream<List<ProductModel>> get productData {
    return _productsStream.stream;
  }

  var progressData = false;

  List<ProductModel> products = [];


  void getProducts() async {
    progressData = true;
    notifyListeners();
    final data = await api.getProducts(_errorStream);
    if (data != null) {
      products = data;
      _productsStream.sink.add(products);
    }
    progressData = false;
    notifyListeners();
  }
}