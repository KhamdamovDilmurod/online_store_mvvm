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

  var progressData = false;

  StreamController<List<ProductModel>> _productsStream = StreamController();

  Stream<List<ProductModel>> get productData {
    return _productsStream.stream;
  }

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

  //////////////

  StreamController<ProductModel> _productByIdStream = StreamController();

  Stream<ProductModel> get productByIdData {
    return _productByIdStream.stream;
  }

  ProductModel? productById = null;

void getProductById(int id) async{
  progressData = true;
  notifyListeners();
  final data = await api.getProductById(id, _errorStream);
  if(data !=null){
    productById = data;
    _productByIdStream.sink.add(productById!);
  }
  progressData = false;
  notifyListeners();
}



}