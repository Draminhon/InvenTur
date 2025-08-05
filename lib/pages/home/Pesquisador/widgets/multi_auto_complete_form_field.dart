import 'package:flutter/material.dart';

class AutocompleteTextField extends StatelessWidget {
  final TextEditingController controllerAuto;
  final String label;
  final AutocompleteOnSelected<String> onSelected;
  final AutocompleteOptionsBuilder<String> optionsBuilder;
  final TextAlign textAlign;

  const AutocompleteTextField({
    super.key,
    required this.controllerAuto,
    required this.label,
    required this.onSelected,
    required this.optionsBuilder,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      initialValue: TextEditingValue(text: controllerAuto.text),
      optionsBuilder: optionsBuilder,
      onSelected: onSelected,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        );
      },
    );
  }
}

// --- O NOVO WIDGET REUTILIZÁVEL ---

class MultiAutocompleteFormField extends StatefulWidget {
  final String title;
  final String label;
  final int fieldCount;
  final AutocompleteOptionsBuilder<String> optionsBuilder;
  final FormFieldSetter<List<String>>? onSaved;
  final FormFieldValidator<List<String>>? validator;
  final List<String>? initialValue;

  const MultiAutocompleteFormField({
    super.key,
    required this.title,
    required this.label,
    this.fieldCount = 5, // Padrão de 5 campos
    required this.optionsBuilder,
    this.onSaved,
    this.validator,
    this.initialValue,
  });

  @override
  State<MultiAutocompleteFormField> createState() =>
      _MultiAutocompleteFormFieldState();
}

class _MultiAutocompleteFormFieldState
    extends State<MultiAutocompleteFormField> {
  // Uma lista de controllers, um para cada campo de texto
  late final List<TextEditingController> _controllers;
  // Uma lista para armazenar o valor selecionado de cada campo
  late final List<String?> _selectedValues;

  @override
  void initState() {
    super.initState();
    // Inicializa a quantidade correta de controllers e valores
    _controllers = List.generate(
      widget.fieldCount,
      (index) => TextEditingController(
        text:
            (widget.initialValue != null && index < widget.initialValue!.length)
                ? widget.initialValue![index]
                : null,
      ),
    );
    _selectedValues = List.generate(
      widget.fieldCount,
      (index) =>
          (widget.initialValue != null && index < widget.initialValue!.length)
              ? widget.initialValue![index]
              : null,
    );
  }

  @override
  void dispose() {
    // Limpa todos os controllers para evitar memory leaks
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<String>>(
      onSaved: widget.onSaved,
      validator: widget.validator,
      initialValue: _selectedValues.whereType<String>().toList(),
      builder: (FormFieldState<List<String>> field) {
        void updateState(int index, String selection) {
          _selectedValues[index] = selection;
          field.didChange(_selectedValues.whereType<String>().toList());
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(),
              ),
              const SizedBox(height: 16),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.fieldCount,
                itemBuilder: (context, index) {
                  return AutocompleteTextField(
                      controllerAuto: _controllers[index],
                      label: "${widget.label} ${index + 1}",
                      optionsBuilder: widget.optionsBuilder,
                      onSelected: (String selection) {
                        // Ao selecionar, atualiza o controller e o estado do FormField
                        _controllers[index].text = selection;
                        updateState(index, selection);
                      },
                    
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 12),
              ),
              // Mostra a mensagem de erro, se houver
              if (field.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    field.errorText!,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
