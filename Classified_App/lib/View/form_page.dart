
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Controller/controller.dart';
import 'package:untitled/Controller/form_controller.dart';
import 'package:untitled/View/quote_view.dart';

import 'package:flutter/material.dart';


class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);


  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Advert'),
      ),
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: const SignUpForm()),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => new _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();

  bool _isLoading = false;

  final Map _product = {
    "description": "",
    "condition": "",
    "packaging": "",
    "warranty": "",
    "minimumBid": 0,
    "shipping": "",
  };


  List<DropdownMenuItem<String>> yesOrNo = [];

  void loadList() {
    yesOrNo = [];
    yesOrNo.add(const DropdownMenuItem(
      child: Text('Yes'),
      value: 'Yes',
    ));
    yesOrNo.add(const DropdownMenuItem(
      child: Text('No'),
      value: 'No',
    ));
  }
  Future<void> onPressedSubmit() async {

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _formKey.currentState!.save();

       if (await PostFormData().submit(_product, context) == 200){
       Scaffold.of(context)
           .showSnackBar(const SnackBar(content: Text('Form Submitted')));
       }
       setState(() {
         _isLoading = false;
       });


    }
  }
  @override
  Widget build(BuildContext context) {
    loadList();
    // Build a Form widget using the _formKey we created above
    return Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Item Name', hintText: 'Name'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Item name';
                }
                return null;
              },
              onSaved: (value) {
                setState(() {
                  _product['description'] = value!;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Condition', labelText: 'Item Condition'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Item Condition';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                setState(() {
                  _product['condition'] = value!;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Amount', labelText: 'Minimum Bid Amount'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Amount';
                } else {
                  return null;
                }
              },
              onSaved: (value) {
                setState(() {
                  _product['minimumBid'] = double.tryParse(value!)!;
                });
              },
            ),
            DropdownButton(
              hint: _product['packaging'].isEmpty? const Text('Packaging') : Text(_product['packaging'],),
              items: yesOrNo,
              onChanged: (value) {
                setState(() {
                  _product['packaging'] = value.toString();
                });
              },
              isExpanded: true,
            ),
            DropdownButton(
              hint: _product['warranty'].isEmpty? const Text('Warranty'): Text(_product['warranty'],),
              items: yesOrNo,
              onChanged: (value) {
                setState(() {
                  _product['warranty'] = value.toString();
                });
              },
              isExpanded: true,
            ),
            DropdownButton(
              hint: _product['shipping'].isEmpty ? const Text('Shipping') : Text(_product['shipping'],),
              items: yesOrNo,
              onChanged: (value) {
                setState(() {
                  _product['shipping'] = value.toString();
                });
              },
              isExpanded: true,
            ),
            RaisedButton(
                color: Colors.blueGrey,
                textColor: Colors.white,
                child: _isLoading ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator( color: Colors.white,),
                    SizedBox(width: 24,),
                    Text('Submitting')
                  ],) : const Text('Submit'),
                onPressed: onPressedSubmit)
          ]
        ));
  }
}
