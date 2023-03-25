import 'package:chat_app/base.dart';
import 'package:chat_app/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_room_view_model.dart';
import 'navigator.dart';

class AddRoomView extends StatefulWidget {
  static const String routeName = 'Room';

  @override
  State<AddRoomView> createState() => _AddRoomViewState();
}

class _AddRoomViewState extends BaseState<AddRoomView,AddRoomViewModel> implements AddRoomNavigator {
  var categories = Category.getCategories();
  late Category selectedItem;
  GlobalKey<FormState> formKey3 = GlobalKey<FormState>();

  String title="";
  String description='';


  @override
  void initState() {
    super.initState();
    selectedItem = categories[0];
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                'Chat App',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                  // width: double.infinity,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black87,
                          blurRadius: 1,
                          offset: Offset(0, 1))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Form(
                    key: formKey3,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        const Text(
                          'Create New Room',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Image.asset('assets/images/group.png',height: 120),
                        TextFormField(
                          onChanged: (text){
                            title = text;
                          },
                          validator: (text){
                            if(text==null || text.trim().isEmpty){
                              return 'enter room title';
                            }
                            return null;
                          },
                          decoration:
                              const InputDecoration(hintText: 'Room Name'),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonFormField<Category>(
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)
                                  )
                                ),
                                isExpanded: true,
                                  value: selectedItem,
                                  items: categories
                                      .map((cat) => DropdownMenuItem<Category>(
                                          value: cat,
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                cat.image,
                                                width: 40,
                                              ),
                                              const SizedBox(width: 10,),
                                              Text(cat.title)
                                            ],
                                          )))
                                      .toList(),
                                  onChanged: ((cat) {
                                    if (cat == null) return;
                                    setState(() {
                                      selectedItem = cat;
                                    });
                                  })),
                            ),
                          ],
                        ),
                        TextFormField(
                          onChanged: (text){
                            description = text;
                          },
                          validator: (text){
                            if(text==null || text.trim().isEmpty){
                              return 'enter room description';
                            }
                            return null;
                          },
                          maxLines: 4,
                          minLines: 4,
                          decoration:
                              const InputDecoration(hintText: 'Room Descreption'),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
                        SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                              )
                            ),
                            onPressed: () {
                              validateForm();
                            },
                            child: const Text('Create',style: TextStyle(fontSize: 16),),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
  void validateForm(){
    if(formKey3.currentState?.validate() == true){
      viewModel.createRoom(title, description, selectedItem.id);

    }

  }

  @override
  AddRoomViewModel initViewModel() {
    return AddRoomViewModel();
  }

  @override
  void roomCreated() {
    showMessage('Room Created');
      hideDialog();

  }
}
