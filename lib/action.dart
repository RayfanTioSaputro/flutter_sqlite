import 'package:flutter/material.dart';
import 'model.dart';

class EntryForm extends StatefulWidget {
  final Model menu;
  EntryForm(this.menu);

  @override
  EntryFormState createState() => EntryFormState(this.menu);
}

class EntryFormState extends State<EntryForm> {
  Model menu;
  EntryFormState(this.menu);

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (menu != null) {
      nameController.text = menu.name;
      priceController.text = menu.price.toString();
      descriptionController.text = menu.description;
    }
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xff2667ff),
          title: Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(right: 80.0)),
              menu == null ? Text('Create') : Text('Update'),
            ],
          ),
          leading: TextButton(
            child: Icon(
                Icons.keyboard_arrow_left,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }
          )
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left:10.0, right:10.0),
          child: ListView(
            children: <Widget> [
              Padding (
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xff2667ff), width: 2.0),
                    ),
                  ),
                ),
              ),
              Padding (
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xff2667ff), width: 2.0),
                    ),
                  ),
                ),
              ),
              Padding (
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: TextField(
                  controller: descriptionController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: const Color(0xff2667ff), width: 2.0),
                    ),
                  ),
                ),
              ),
              Padding (
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: <Widget> [
                    Expanded(
                      child: OutlineButton(
                        borderSide: BorderSide(
                            color: const Color(0xff2667ff)
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.5),
                        ),
                        textColor: const Color(0xff2667ff),
                        child: Text(
                            "Cancel"
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(width: 5.0,),
                    Expanded(
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.5),
                        ),
                        color: const Color(0xff2667ff),
                        textColor: Colors.white,
                        child: Text(
                            "Save"
                        ),
                        onPressed: () {
                          if (menu == null) {
                            menu = Model(
                                nameController.text,
                                int.parse(priceController.text),
                                descriptionController.text
                            );

                          } else {
                            menu.name = nameController.text;
                            menu.price = int.parse(priceController.text);
                            menu.description = descriptionController.text;
                          }
                          Navigator.pop(context, menu);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}