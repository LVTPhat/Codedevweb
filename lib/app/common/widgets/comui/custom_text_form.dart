import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String label;
  final String? initialValue;
  final InputDecoration? decoration;
  final String? Function(String?)? validator;

  void Function(String?)? onSaved;

  CustomTextForm(
      {Key? key,
      required this.label,
      this.initialValue,
      this.onSaved,
      this.decoration,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        child: Stack(
          children: [
            Expanded(
              child: Container(
                height: 48,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blue[100],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        label,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                Expanded(
                    flex: 7,
                    child: Container(
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white70),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white70,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 168, 212, 248),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextFormField(
                            onSaved: this.onSaved,
                            initialValue: this.initialValue,
                            decoration: this.decoration,
                            validator: this.validator,
                          ),
                        ))),
              ],
            ),
          ],
        ));
  }
}
