import 'package:example/model/expense.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/expense.dart';

//For API call
class APIManager {
  //Get the Expense Data
  Future<List<Expense>> getExpense(int page) async {
    var client = http.Client();
    List<Expense> expenses = [];
    
    try {
      //page for scrolling and get new page
      var response = await client
          .get("http://10.0.2.2:5000/api/expenses?page="+page.toString()+"&per_page=10");
      //If success, then get the data to the list
      if (response.statusCode == 200) {
        var data = response.body.toString();
        var list = json.decode(data);
        list["data"].forEach((item)=>{
          expenses.add(Expense.fromJson(item))
        });
      }
    } catch (Exception) {
      expenses = [];
      print(Exception);
    }
    return expenses;
  }

  void postExpense(String name, String date, String amount,String category) async {
    //Create new Expense
    try{
      http.post("http://10.0.2.2:5000/api/expense",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },body: jsonEncode(<String, dynamic>{
      'name': name,
      'created_at': date,
      'amount':int.parse(amount),
      'category': category
    }));
    }
    catch(Exception){
      print(Exception);
    } 
  }
  void createNewUser()async{

  }
  void login() async{

  }
}
