import 'package:flutter/material.dart';

class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier{
  N? navigator = null;
}

abstract class BaseNavigator{}

abstract class BaseState<T extends StatefulWidget,VM extends BaseViewModel>extends State<T>{
  late VM viewModel;
  VM initViewModel();
  @override
  void initState(){
    super.initState();
    viewModel = initViewModel();
  }
}
