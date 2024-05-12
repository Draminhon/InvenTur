import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AutocompleteTextField extends StatelessWidget {
  final String label;
  final TextInputType? keyboardType;
  final Function(String value)? onChanged;
  final Function(String option) onSelected;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final AutocompleteOptionsBuilder<String> optionsBuilder;
  final Function(TextEditingController textEditingController)? onStateChanged;

  const AutocompleteTextField({
    super.key,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.onStateChanged,
    this.inputFormatters,
    required this.label, 
    required this.onSelected,
    required this.optionsBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Autocomplete<String>(
        optionsBuilder: (textEditingValue) => optionsBuilder(textEditingValue),
        onSelected: onSelected,
        optionsViewBuilder: (context, onSelected, options) => Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              width: constraints.biggest.width,
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: options.length,
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 0,
                    color: Color.fromARGB(255, 55, 111, 60),
                  );
                },
                itemBuilder: (context, index) {
                  final String option = options.elementAt(index);
                  return InkWell(
                    borderRadius: options.length == 1
                    ? const BorderRadius.all(Radius.circular(10))
                    : index == 0
                      ? const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )
                      : index == options.length - 1
                        ? const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )
                        : null,
                    onTap: () => onSelected(option),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        option,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 55, 111, 60),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
          if (onStateChanged != null) onStateChanged!(textEditingController);
          return TextFormField(
            focusNode: focusNode,
            validator: validator,
            textAlign: TextAlign.end,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            controller: textEditingController,
            decoration: InputDecoration(
              filled: true,
              isCollapsed: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(10),
              labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color.fromARGB(255, 55, 111, 60))
              ),
            ),
            onChanged: onChanged,
          );
        },
      ),
    );
  }
}