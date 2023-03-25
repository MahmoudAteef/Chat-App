import 'package:flutter/material.dart';

class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier{
  N? navigator=null;
}

abstract class BaseNavigator{
  void showMessage(String message);
  void showLoading({String message});
  void hideDialog();
}

abstract class BaseState<T extends StatefulWidget,VM extends BaseViewModel>extends State<T> implements BaseNavigator{
  late VM viewModel;
  VM initViewModel();
  @override
  void initState(){
    super.initState();
    viewModel = initViewModel();
  }

  @override
  void showMessage(String message){
    Center(child: CircularProgressIndicator());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void showLoading({String message = 'Loading...'}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void hideDialog(){
    Navigator.pop(context);
  }

}
