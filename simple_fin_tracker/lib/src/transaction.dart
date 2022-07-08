

// transaction model for validating the input and writing csv
class Transaction {
	final String amount;
	final String tags;
	final String? comment;
	final bool isOutgoing;

	Transaction({required this.amount, required this.tags, required this.isOutgoing, this.comment});

	Transaction.fromList(List fields): this(
			amount: fields[0].trim(), 
			tags: fields[1].trim(),
			comment: fields[2],
			isOutgoing: fields[3].toLowerCase() == 'true'));

	
}
