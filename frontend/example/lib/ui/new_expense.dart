import 'package:example/data/apimanager.dart';
import 'package:flutter/material.dart';

import '../model/category.dart';

class NewExpenseScreen extends StatefulWidget {
  NewExpenseScreen({Key key}) : super(key: key);

  @override
  _NewExpenseScreenState createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  Category _selectedCategory;
  final nameController = TextEditingController();
  final createdAtController = TextEditingController();
  final amountController = TextEditingController();
  void _onPressedCategory(Category category) {
    setState(() {
      _selectedCategory = category;
    });
  }
  //check user date input
  bool checkDate(String date) {
    RegExp regExp = new RegExp(r'^\d{4}-\d{2}-\d{2}$');
    return regExp.hasMatch(date);
  }
  //check user amount input
  bool checkAmount(String amount) {
    RegExp regExp = new RegExp(r'^[+]?\d+([.]\d+)?$');
    return regExp.hasMatch(amount);
  }

  @override
  void dispose() {
    nameController.dispose();
    createdAtController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Add Expense'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              //Name
              SizedBox(height: 24.0),
              Container(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                // padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blueGrey,
                ),
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Text('Name', style: TextStyle(color: Colors.white)),
                  SizedBox(height: 12.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Name', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 24.0),
                        Expanded(
                          child: Container(
                            height: 36.0,
                            child: Center(
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  hintText: 'Name',
                                ),
                                // textAlign: TextAlign.center,
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                        )
                      ]),
                ]),
              ),
              SizedBox(height: 24.0),
              // amount
              Container(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                // padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blueGrey,
                ),
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Text('Amount', style: TextStyle(color: Colors.white)),
                  SizedBox(height: 12.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('HKD', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 24.0),
                        Expanded(
                          child: Container(
                            height: 36.0,
                            child: Center(
                              child: TextField(
                                controller: amountController,
                                decoration: InputDecoration(
                                  hintText: '00.00',
                                ),
                                // textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        )
                      ]),
                ]),
              ),

              // date
              SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blueGrey,
                ),
                child: Column(children: <Widget>[
                  Text('Date', style: TextStyle(color: Colors.white)),
                  SizedBox(height: 12.0),
                  Container(
                    height: 36.0,
                    child: Center(
                      child: TextField(
                        controller: createdAtController,
                        decoration: InputDecoration(
                          hintText: 'YYYY-MM-DD',
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ]),
              ),

              // category
              SizedBox(height: 16.0),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blueGrey,
                ),
                child: Column(children: <Widget>[
                  Text('Category', style: TextStyle(color: Colors.white)),
                  SizedBox(height: 12.0),
                  Row(children: [
                    Expanded(child: Container()),
                    Container(
                      width: (42.0 + 20.0) * 3 + 42.0,
                      child: Wrap(
                        runSpacing: 20.0,
                        spacing: 20.0,
                        children: Category.values.map((e) {
                          final child = Container(
                            width: 42.0,
                            height: 42.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white),
                            ),
                            child: MaterialButton(
                              shape: CircleBorder(),
                              padding: EdgeInsets.zero,
                              onPressed: () => _onPressedCategory(e),
                              child: Center(
                                child: e.iconWidget(),
                              ),
                            ),
                          );
                          return e == _selectedCategory
                              ? Badge(
                                  size: 8.0,
                                  offset: 1.0,
                                  child: child,
                                )
                              : child;
                        }).toList(),
                      ),
                    ),
                    Expanded(child: Container()),
                  ]),
                  SizedBox(height: 8.0),
                ]),
              ),

              // done
              SizedBox(height: 40.0),
              Center(
                child: Container(
                    height: 40.0,
                    child: MaterialButton(
                      child:
                          Text('Done', style: TextStyle(color: Colors.white)),
                      shape: StadiumBorder(),
                      color: Colors.blueGrey,
                      onPressed: () {
                        if (nameController.text != "" &&
                            createdAtController.text != "" &&
                            amountController.text != "" &&
                            _selectedCategory != null &&
                            checkDate(createdAtController.text) &&
                            checkAmount(amountController.text)) {
                          APIManager().postExpense(
                              nameController.text,
                              createdAtController.text,
                              amountController.text,
                              _selectedCategory.name);
                          Navigator.pop(context,(){setState(() {});});
                        }
                      },
                    )),
              ),
            ]),
          ),
        ));
  }
}

class Badge extends StatelessWidget {
  final Widget child;
  final dynamic offset;
  final double size;
  final Color color;

  const Badge({
    Key key,
    @required this.child,
    this.offset = 0.0,
    this.size = 11.0,
    this.color = const Color(0xFF33D176),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(overflow: Overflow.visible, children: <Widget>[
      child,
      Positioned(
        top: offset is Offset ? offset.dy : offset,
        right: offset is Offset ? offset.dx : offset,
        width: size,
        height: size,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    ]);
  }
}
