import 'package:flutter/material.dart' hide Actions;
import '../model/expense.dart';
import '../data/apimanager.dart';

String selected = "";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mone Expense App'),
        actions:
            //       <Widget>[SortingButton()],
            <Widget>[SortingButton(), SettingsButton()],
      ),
      body: Transactions(),
      floatingActionButton: AddTransactionButton(),
    );
  }
}

class ExpenseList extends StatefulWidget {
  final List<Expense> expenses;
  const ExpenseList({this.expenses, Key key}) : super(key: key);

  @override
  _ExpenseListState createState() => _ExpenseListState();
}
void sortByDate(List<Expense> data) {
    
    data.sort((a, b) {
      return a.createdAt.compareTo(b.createdAt);
    });
  }

  void sortByMonth(List<Expense> data) {
    data.sort((a, b) {
      return a.createdAt.split("-")[1].compareTo(b.createdAt.split("-")[1]);
    });
  }

  void sortByCategory(List<Expense> data) {
    data.sort((a, b) {
      return a.category.compareTo(b.category);
    });
  }
class _ExpenseListState extends State<ExpenseList> {
  ScrollController scrollController = new ScrollController();
  List<Expense> expenses;
  int currentPage = 1;
  bool isLoading = false;
  bool onNotificatin(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (scrollController.position.maxScrollExtent > scrollController.offset &&
          scrollController.position.maxScrollExtent - scrollController.offset <=
              50) {
        if (!isLoading) {
          isLoading = !isLoading;
          APIManager().getExpense(currentPage + 1).then((val) {
            if (val.length > 0) {
              currentPage += 1;
              setState(() {
                expenses.addAll(val);
              });
              switch (selected) {
                case "Date":
                  {
                    sortByDate(expenses);
                    break;
                  }
                case "Month":
                  {
                    sortByMonth(expenses);
                    break;
                  }
                case "Category":
                  {
                    sortByCategory(expenses);
                    break;
                  }
              }
            }
            isLoading = false;
          });
        }
      }
    }
    return true;
  }



  @override
  void initState() {
    expenses = widget.expenses;
    switch (selected) {
      case "Date":
        {
          sortByDate(expenses);
          break;
        }
      case "Month":
        {
          sortByMonth(expenses);
          break;
        }
      case "Category":
        {
          sortByCategory(expenses);
          break;
        }
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        onNotification: onNotificatin,
        child: ListView.builder(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: expenses.length, // transactions.length
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: EdgeInsets.fromLTRB(4, (index == 0) ? 8 : 0, 4,
                (index == expenses.length - 1) ? 8 : 0), // txn length!!!!!!
            child: Card(
              color: Colors.blueGrey,
              elevation: 3,
              child: InkWell(
                onTap: () => {},
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: FormattedJournalItem(
                    expense: expenses[index],
                    dark: Theme.of(context).brightness == Brightness.dark,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
class Transactions extends StatefulWidget{
  _TransactionsState createState() => _TransactionsState();
}
class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    // Transaction transactions = new Transaction('2020-02-02','txn 1',List<Posting>());
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 1.0,
          child: RefreshIndicator(
            onRefresh: () {},
            child: FutureBuilder<List<Expense>>(
                future: APIManager().getExpense(1),
                builder: (context, AsyncSnapshot<List<dynamic>> async) {
                  if (async.connectionState == ConnectionState.active ||
                      async.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("loading..."),
                    );
                  }
                  if (async.connectionState == ConnectionState.done) {
                    if (async.hasError) {
                      return Center(
                        child: Text("error1"),
                      );
                    } else if (async.hasData &&
                        async.data != null &&
                        async.data.length > 0) {
                      List resultList = async.data;
                        switch(selected) {
                case "Date":
                  {
                    sortByDate(resultList);
                    break;
                    
                  }
                case "Month":
                  {
                    sortByMonth(resultList);
                    break;
                  }
                case "Category":
                  {
                    sortByCategory(resultList);
                    break;
                    
                  }
                  
              }
              return new ExpenseList(
                        expenses: resultList,
                      );
                    }
                  } else {
                    return Center(
                      child: Text("error2"),
                    );
                  }
                  return Center(
                    child: Text("error3"),
                  );
                }),
          ),
        ),
      ],
    );
  }
}

class FormattedJournalItem extends StatelessWidget {
  const FormattedJournalItem({@required this.expense, @required this.dark});

  final Expense expense;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    Widget formattedJournalItem;
    final Color color = Colors.white;

    if (expense is Expense) {
      final String date = expense.createdAt;
      final String name = expense.name;
      final String category = expense.category;
      final double amount = expense.amount;
      final Widget column = Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              FormatString(
                text: date,
                color: color,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          // const FormatString(text: ' '),
                          SizedBox(
                            width: 20,
                          ),
                          FormatString(
                            text: name,
                            color: color,
                          ),
                          // const FormatString(text: '   '),
                          SizedBox(
                            width: 20,
                          ),
                          FormatString(
                            text: '\$',
                            color: color,
                          ),
                          FormatString(
                            text: amount.toString(),
                            color: color,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const FormatString(text: ' '),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const FormatString(text: ' '),
                          FormatString(
                            text: category,
                            color: color,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
      formattedJournalItem = column;
    }
    return formattedJournalItem;
  }
}

class FormatString extends StatelessWidget {
  const FormatString({@required this.text, this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
      ),
      style: TextStyle(
        // fontFamily: 'IBMPlexMono',
        color: color,
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: const Key('Settings'),
      icon: const Icon(Icons.settings),
      onPressed: () {
        Navigator.pushNamed(context, '/settings');
        print('navigate to setting');
      },
    );
  }
}

class SortingButton extends StatefulWidget {
  @override
  _SortingButtonState createState() => _SortingButtonState();
}

class _SortingButtonState extends State<SortingButton> {
  final List<String> dropdownValues = [
    "Date",
    "Month",
    "Category",
  ];
  String currentlySelected = "Date";

  Widget build(BuildContext context) {
    return (DropdownButton<String>(
      items: dropdownValues
          .map((value) => DropdownMenuItem(
                child: Text(value),
                value: value,
              ))
          .toList(),
      onChanged: (String value) {
        selected = value;
        setState(() {
          currentlySelected = value;
        });
        
        print(selected);
      },
      isExpanded: false,
      value: currentlySelected,
    ));
  }
}

class AddTransactionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag:
          '''the only floating action button here ${DateTime.now().millisecondsSinceEpoch}''',
      onPressed: () {
        print('FloatingActionButton got pressed');
        Navigator.pushNamed<dynamic>(context, '/new_expense');
      },
      child: const Icon(Icons.add),
    );
  }
}
