import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  final String message;
  final DateTime date;
  final String? email;

  const MessageWidget(this.message, this.date, this.email, {Key? key})
      : super(key: key);

  String checkDate(){
     final DateTime now = DateTime.now();
     final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 1, top: 5, right: 1, bottom: 2),
        child: Column(
          children: [
            if (email != null) ...[
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      email!,
                      style: const TextStyle(color: Colors.grey,  fontSize: 12),
                    )),
              ),
            ],
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: buildMessageCard(message)),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    DateFormat('yyyy-MM-dd, kk:mma')
                        .format(date)
                        .toString(),
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  )),
            ),
          ],
        ));
  }

  Widget buildMessageCard(message) {
    return Card(
      child: SizedBox(
        width: 300,
        // height: 100,
        child:
            Padding(padding: const EdgeInsets.all(8.0), child: Text(message)),
      ),
    );
  }


}
