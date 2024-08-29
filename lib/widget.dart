import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final controllerOne = TextEditingController(text: 'start text');
  final controllerTwo = TextEditingController(text: 'start string');
  final nodeOne = FocusNode();
  final nodeTwo = FocusNode();

  // void onListen() {
  //   controllerTwo.text = controllerOne.text.toUpperCase();
  // }

  void onButtonTap() {
    // controllerOne.value = const TextEditingValue(
    //   text: 'Text',
    //   selection: TextSelection(
    //     baseOffset: 1,
    //     extentOffset: 3,
    //   ),
    // );
    // controllerOne.addListener(onListen);
    // controllerOne.removeListener(onListen);
    // controllerTwo.clear();
    // print(nodeOne.hasFocus);
    // print(nodeTwo.hasFocus);
    nodeOne.nextFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ElevatedButton(
            //   onPressed: onButtonTap,
            //   child: const Text('Press'),
            // ),
            // const SizedBox(height: 5),
            // TextField(
            //   //focusNode: nodeOne,
            //   // controller: controllerOne,
            //   decoration: InputDecoration(
            //     // enabled: false,//(the default value is true)
            //     enabledBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(5),
            //       borderSide: const BorderSide(
            //         color: Colors.black,
            //         width: 2,
            //       ),
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10),
            //       borderSide: const BorderSide(
            //         color: Colors.blue,
            //         width: 2,
            //       ),
            //     ),
            //     // icon: const Icon(Icons.ac_unit),
            //     // labelText: 'phone',
            //     // labelStyle: const TextStyle(
            //     //   color:Colors.amber,
            //     // ),
            //     // helperText: 'helperText',
            //     // hintText: 'hintText',
            //     // errorText: 'errorText',
            //     // counterText: '',
            //     // prefixIcon: const Icon(Icons.phone),
            //     // prefixText: '+7',
            //     isCollapsed: true,
            //     contentPadding: const EdgeInsets.all(20),
            //   ),
            //   // enabled: false,
            //   // readOnly: true,
            //   // keyboardAppearance: Brightness.light,
            //   textInputAction: TextInputAction.next,
            //   // keyboardType: TextInputType.number,
            //   // showCursor: false,
            //   // cursorWidth: 17,
            //   // cursorHeight: 17,
            //   // cursorRadius: const Radius.circular(17),
            //   cursorColor: Colors.blue,
            //   // obscureText: true,
            //   // obscuringCharacter: ' ',
            //   // autocorrect: true,
            //   // enableSuggestions: false,
            //   // textCapitalization: TextCapitalization.words,
            //   // smartDashesType: SmartDashesType.enabled,
            //   // smartQuotesType: SmartQuotesType.enabled,
            //   // enableInteractiveSelection: false,
            //   // selectionHeightStyle: BoxHeightStyle.tight,
            //   // selectionControls: CupertinoTextSelectionControls(),
            //   // maxLines: null,
            //   // minLines: null,
            //   // expands: true,
            //   // maxLength: 10,
            //   // textAlign: TextAlign.center,
            // ),
            // const SizedBox(
            //   height: 40,
            // ),
            TextField(
              // textInputAction: TextInputAction.next,
              // focusNode: nodeTwo,
              // controller: controllerTwo,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              inputFormatters: [
                // FilteringTextInputFormatter.deny(
                //   RegExp(r'[r,t,y]+'),
                //   replacementString: '-',
                // ),
                PhoneInputFormatter(),
                LengthLimitingTextInputFormatter(13),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//123 456 78 99

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]+'), '');

    final initialSpeshialSimbolCount = newValue.selection
        .textBefore(newValue.text)
        .replaceAll(RegExp(r'[\d]+'), '')
        .length;
    final cursorPosition =
        newValue.selection.start - initialSpeshialSimbolCount;
    var finalCursorPosition = cursorPosition;
    final digitsOnlyChars = digitsOnly.split('');

    if (oldValue.selection.textBefore(oldValue.text).endsWith(' ')) {
      digitsOnlyChars.removeAt(cursorPosition - 1);
      finalCursorPosition -= 2;
    }

    var newString = <String>[];
    for (var i = 0; i < digitsOnlyChars.length; i++) {
      if (i == 3 || i == 6 || i == 8) {
        newString.add(' ');
        newString.add(digitsOnlyChars[i]);
        if (i <= cursorPosition) finalCursorPosition += 1;
      } else {
        newString.add(digitsOnlyChars[i]);
      }
    }

    final resultString = newString.join('');

    return TextEditingValue(
      text: resultString,
      selection: TextSelection.collapsed(offset: finalCursorPosition),
    );
  }
}
