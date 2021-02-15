import 'package:flutter/material.dart';
import 'dart:async';
import 'crud.dart';
import 'model.dart';
import 'action.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CRUD dbHelper = CRUD();
  Future<List<Model>> future;

  void initState() {
    super.initState();
    updateListView();
  }

  void updateListView() {
    setState(() {
      future = dbHelper.getAll();
    });
  }

  Future<Model> navigateToEntryForm(BuildContext context, Model client) async {
    var result = await Navigator.push(context, MaterialPageRoute(
        builder: (BuildContext context) {
          return EntryForm(client);
        }
    ));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2667ff),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('List Menu')
          ],
        )
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 22.0, bottom: 85.0, left: 6.0, right: 6.0),
        children: [
          FutureBuilder<List<Model>>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    children: snapshot.data.map((todo) => card(todo)).toList()
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff2667ff),
        child: Icon(Icons.add),
        tooltip: 'Tambah Data',
        onPressed: () async {
          var contact = await navigateToEntryForm(context, null);
          if (contact != null) {
            int result = await dbHelper.insert(contact);
            if (result > 0) {
              updateListView();
            }
          }
        },
      ),
    );
  }

  Card card(Model menu) {
    final currency = new NumberFormat("#,##0", "en_US");
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      elevation: 5.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color.fromRGBO(38, 103, 255, .25),
          child: Icon(
            Icons.fastfood,
            size: 18,
            color: const Color(0xff2667ff),
          ),
        ),
        title: Text(
          menu.name,
          style: TextStyle(
            fontSize: 18
          ),
        ),
        subtitle: Text('Rp ' + currency.format(menu.price)),
        trailing: GestureDetector(
          child: Icon(
            Icons.delete,
            color: Color.fromRGBO(248, 65, 65, .5),
          ),
          onTap: () async {
            int result = await dbHelper.delete(menu);
            if (result > 0) {
              updateListView();
            }
          },
        ),
        onTap: () async {
          var menu2 = await navigateToEntryForm(context, menu);
          if (menu2 != null) {
            int result = await dbHelper.update(menu2);
            if (result > 0) {
              updateListView();
            }
          }
        },
      ),
    );
  }
}