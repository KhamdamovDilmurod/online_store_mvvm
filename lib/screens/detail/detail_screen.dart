import 'package:flutter/material.dart';
import 'package:online_store_mvvm/viewModel/view_model.dart';
import 'package:stacked/stacked.dart';

class DetailScreen extends StatefulWidget {
  final int id;

  DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("detail"),
      ),
      body: ViewModelBuilder<MainViewModel>.reactive(
        viewModelBuilder: () {
          return MainViewModel();
        },
        builder:
            (BuildContext context, MainViewModel viewModel, Widget? child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                viewModel.progressData
                    ? CircularProgressIndicator()
                    : Image.network(viewModel.productById!.image),
              ],
            ),
          );
        },
        onViewModelReady: (viewModel) {
          viewModel.getProductById(widget.id);
        },
      ),
    );
  }
}
