import 'package:flutter/material.dart';


class TrackingDialog extends StatefulWidget {
	TrackingDialog({Key? key}) : super(key: key);

	@override
	State<TrackingDialog> createState() => _TrackingState();
}

class _TrackingState extends State<TrackingDialog> {
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

	void collectData() {

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
							onPressed: () => collectData(),
						child: const Text("Save"),
					))
				])
		  ));
	}
}
