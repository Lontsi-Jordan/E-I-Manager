import 'package:budget_manager/models/expense.dart';
import 'package:budget_manager/models/user.dart';
import 'package:budget_manager/screens/transactions..dart';
import 'package:budget_manager/services/database_expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'home_screen.dart';
class ExpenseScreen extends StatefulWidget {
  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _dateController = new TextEditingController();
  var _categories = [
    "Food",
    "Transport",
    "Personnal",
    "Shopping",
    "Medical",
    "Rent",
    "Movie",
    "Salary"
  ];
  var _mode = [
    "Espèce",
    "Chèque",
  ];
  String _categoriesSelectedValue;
  String _modeSelected;
  String amount;
  String note;
  String _dateFormat = DateFormat('yyyy-MM-dd').format(new DateTime.now());
  String dateTime;
  Future<Null> _selectedDate(BuildContext context) async{
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2020),
        lastDate: new DateTime(2021),
    );
    if(picked != null){
      setState(() {
        _dateFormat = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final DatabaseExpense databaseExpense = DatabaseExpense();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense',style: TextStyle(
            fontFamily: 'Billabong',
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w500,
          letterSpacing: 1
        ),),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: <Widget>[
                    FormField<String>(
                      builder: (FormFieldState<String> state){
                        return InputDecorator(
                          decoration: InputDecoration(
                            hintText: 'Please select category',
                            labelText: 'Category',
                            labelStyle: TextStyle(
                                fontFamily: 'Open Sans',
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5
                            ),
                            hintStyle: TextStyle(
                              fontFamily: 'Open Sans',
                              color: Colors.black,
                                fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.5
                            ),
                            errorStyle: TextStyle(color: Colors.redAccent,fontSize: 13.0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                          ),
                          isEmpty: _categoriesSelectedValue == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _categoriesSelectedValue,
                              isDense: true,
                              onChanged: (String newValue){
                                setState(() {
                                  _categoriesSelectedValue = newValue;
                                  state.didChange(newValue);
                                });
                              },
                              items: _categories.map((String value){
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0,
                                      color: Colors.black,
                                      letterSpacing: 0.5
                                  ),),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                      onSaved: (value){
                        setState(() {
                          _categoriesSelectedValue = value;
                        });
                      },
                      /*validator: (value){
                        if(value.isEmpty){
                          return 'Category is required';
                        }
                        return null;
                      },*/
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        labelStyle: TextStyle(
                            fontFamily: 'Open Sans',
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5
                        ),
                        errorStyle: TextStyle(color: Colors.redAccent,fontSize: 13.0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                      ),
                      onSaved: (value){
                        setState(() {
                          amount = value;
                        });
                      },
                      validator: (value){
                        if(value.isEmpty){
                          return 'Amout is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0,),
                    FormField<String>(
                      builder: (FormFieldState<String> state){
                        return InputDecorator(
                          decoration: InputDecoration(
                            hintText: 'Please select mode',
                            labelText: 'Mode',
                            labelStyle: TextStyle(
                                fontFamily: 'Open Sans',
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5
                            ),
                            hintStyle: TextStyle(
                                fontFamily: 'Open Sans',
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.5
                            ),
                            errorStyle: TextStyle(color: Colors.redAccent,fontSize: 16.0),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                          ),
                          isEmpty: _modeSelected == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _modeSelected,
                              isDense: true,
                              onChanged: (String newValue){
                                setState(() {
                                  _modeSelected = newValue;
                                  state.didChange(newValue);
                                });
                              },
                              items: _mode.map((String value){
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                      letterSpacing: 0.5
                                  ),),
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                      onSaved: (value){
                        setState(() {
                          _modeSelected = value;
                        });
                      },
                      /*validator: (String value){
                        if(value.isEmpty){
                          return 'Mode of paiement is required';
                        }
                        return null;
                      },*/
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      controller: _dateController,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        labelStyle: TextStyle(
                            fontFamily: 'Open Sans',
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5
                        ),
                        errorStyle: TextStyle(color: Colors.redAccent,fontSize: 13.0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.date_range,size: 14,),
                          onPressed: () async {
                            final DateTime picked = await showDatePicker(
                              context: context,
                              initialDate: new DateTime.now(),
                              firstDate: new DateTime(2020),
                              lastDate: new DateTime(2021),
                            );
                            if(picked != null){
                              setState(() {
                                _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
                              });
                            }
                          }
                        ),
                      ),
                      onSaved: (value){
                        setState(() {
                          dateTime = value;
                        });
                      },
                      validator: (value){
                        if(value.isEmpty){
                          return 'Date is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      maxLines: 2,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        labelStyle: TextStyle(
                            fontFamily: 'Open Sans',
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5
                        ),
                        errorStyle: TextStyle(color: Colors.redAccent,fontSize: 13.0),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                      ),
                      onSaved: (value){
                        setState(() {
                          note = value;
                        });
                      },
                      validator: (value){
                        if(value.isEmpty){
                          return 'Description is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.0,),
                    GestureDetector(
                      onTap: ()async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          Expense exp = new Expense(_categoriesSelectedValue, amount, _modeSelected, dateTime, note,user.uid);
                          databaseExpense.addExpense(exp)
                          .then((result) {
                            Toast.show("Expense created", context,backgroundColor: Colors.greenAccent,textColor: Colors.white,gravity: Toast.TOP,duration: 3);
                            Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context)=>Transactions()));
                          })
                          .catchError((e)=> Toast.show("This email is already use", context,backgroundColor: Colors.red,textColor: Colors.white,gravity: Toast.BOTTOM,duration: 3));

                        } else {
                          Toast.show("All fields are required", context,backgroundColor: Colors.red,textColor: Colors.white,gravity: Toast.TOP,duration: 3);
                        }
                      },
                      child: Container(
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(50.0)
                        ),
                        child: Text('SAVE',style: TextStyle(letterSpacing: 0.5,fontWeight: FontWeight.bold,color:Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
