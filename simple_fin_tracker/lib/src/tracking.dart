import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';


import './tracking.dart';

class TrackingDialog extends StatefulWidget {
	final String path;
	TrackingDialog({required this.path}) : super();

	@override
	State<TrackingDialog> createState() => _TrackingState(path: path);
}

class _TrackingState extends State<TrackingDialog> {
	final String path;
	_TrackingState({required this.path}) : super();
	// controllers -> text input
	final _amountController = TextEditingController();  // raw amount
	final _tagsController = TextEditingController();  // transaction function for now strings devided by ;
	final _commentController = TextEditingController();  // transaction coment
	final _accountController = TextEditingController();  // origin of transaction: cash, account1, etc.


	// variables to update
	String? _amount = null;
	String? _tags = null;
	String? _comment = null;
	String? _account = null;
	bool _outgoingFlow = true;
	String csv = ""; 

	generateCsv() async {
		List<dynamic> row = [];
		row.add(_amountController.value.text);
		row.add(_tagsController.value.text);
		row.add(_commentController.value.text);
		row.add(_accountController.value.text);
		row.add(_outgoingFlow);

		data.add(row);
		// writing data into file
		String dir = (await getApplicationDocumentsDirectory()).path;
		String filePath = "$dir/budget.csv";
		File file = File(filePath);
		olderData.add(row);
		csv = const ListToCsvConverter().convert(olderData);  // is there a better way to work with a data class directly?
		await file.writeAsString(csv);

		// reset controllers after csv write
		_amountController.clear();
		_tagsController.clear();
		_commentController.clear();
		_accountController.clear();
		_outgoingFlow = true;
		csv = "";
	}



	@override
	Widget build(BuildContext context) {
		double screenWidth = MediaQuery.of(context).size.width;
		double screenHeight = MediaQuery.of(context).size.height;
		double dialogWidth = screenWidth * 0.9;
		double dialogHeight = screenHeight * 0.8;
		return Dialog(
			child: Container(
			width: dialogWidth, 
			height: dialogHeight,
			child: Column(
				children: <Widget>[
					Expanded(child:Padding(
						padding: EdgeInsets.fromLTRB(dialogWidth * 0.05, 0, dialogWidth * 0.05, 0),
						child:TextFormField(
							decoration: const InputDecoration(
								border: UnderlineInputBorder(),
								labelText: 'Transaction amount'),
							controller: _amountController,
					))),
					Expanded(child:Padding(
						padding: EdgeInsets.fromLTRB(dialogWidth * 0.05, 0, dialogWidth * 0.05, 0),
						child:TextFormField(
						decoration: const InputDecoration(
						border: UnderlineInputBorder(),
						labelText: 'Tags'),
						controller: _tagsController,
					))),
					Expanded(child:Padding(
						padding: EdgeInsets.fromLTRB(dialogWidth * 0.05, 0, dialogWidth * 0.05, 0),
						child:TextFormField(
						decoration: const InputDecoration(
						border: UnderlineInputBorder(),
						labelText: 'Comments'),
						controller: _commentController,
					))),
					Expanded(child:Padding(
						padding: EdgeInsets.fromLTRB(dialogWidth * 0.05, 0, dialogWidth * 0.05, 0),
						child:TextFormField(
						decoration: const InputDecoration(
						border: UnderlineInputBorder(),
						labelText: 'Account'),
						controller: _accountController,
					))),
					Expanded(child:Padding(
						padding: EdgeInsets.fromLTRB(dialogWidth * 0.05, 0, dialogWidth * 0.05, 0),
						child:Row(children: <Widget>[
							Expanded(child:RadioListTile<bool>(
									title: const Text('Out'),
									value: true,
									groupValue: _outgoingFlow,
									onChanged: (bool? value) {
										setState(() {_outgoingFlow = value!;});
								})),
							Expanded(child:RadioListTile<bool>(
									title: const Text('In'),
									value: false,
									groupValue: _outgoingFlow,
									onChanged: (bool? value) {
										setState(() {_outgoingFlow = value!;});
								}))
						]))),
					Padding(
						padding: EdgeInsets.fromLTRB(0, 25, 0, 15),
						child: FloatingActionButton(
							onPressed: () {
								generateCsv();
								Navigator.pop(context);
							},
							child: const Text("Save"),
					))
				])
		  ));
	}
}
