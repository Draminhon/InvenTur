import 'package:flutter/material.dart';

// --- WIDGET AUXILIAR: AutocompleteTextField ---
// Adicionamos um novo callback: onSubmitted

class AutocompleteTextField extends StatelessWidget {
  final TextEditingController controllerAuto;
  final String label;
  final AutocompleteOnSelected<String> onSelected;
  final AutocompleteOptionsBuilder<String> optionsBuilder;
  final TextAlign textAlign;
  final ValueChanged<String>? onSubmitted; // <-- NOVO: Callback para submissão

  const AutocompleteTextField({
    super.key,
    required this.controllerAuto,
    required this.label,
    required this.onSelected,
    required this.optionsBuilder,
    this.textAlign = TextAlign.start,
    this.onSubmitted, // <-- NOVO: Adicionado ao construtor
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      initialValue: TextEditingValue(text: controllerAuto.text),
      optionsBuilder: optionsBuilder,
      onSelected: onSelected,
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
        // Conectamos o onSubmitted do widget ao onFieldSubmitted do TextFormField
        // para capturar o valor quando o usuário finaliza a digitação.
        focusNode.addListener(() {
          if (!focusNode.hasFocus) {
             // Se o campo perdeu o foco e o onSubmitted não foi disparado,
             // garantimos que o valor atual seja salvo.
             onSubmitted?.call(textEditingController.text);
          }
        });

        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          textAlign: textAlign,
          // Chamamos o onFieldSubmitted original para manter o comportamento padrão
          // e também o nosso novo callback para salvar o estado.
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
            onSubmitted?.call(value); // <-- ALTERADO: Chama nosso callback
          },
        );
      },
    );
  }
}

// --- O NOVO WIDGET REUTILIZÁVEL ---
// Nenhuma alteração estrutural, apenas no uso do AutocompleteTextField

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
  late final List<TextEditingController> _controllers;
  late final List<String?> _selectedValues;

  @override
  void initState() {
    super.initState();
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
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<String>>(
      // Ao invés de passar o onSaved diretamente, nós o envolvemos
      // para garantir que os valores finais dos controllers sejam lidos.
      onSaved: (value) {
        if (widget.onSaved != null) {
          final finalValues = _controllers
              .map((controller) => controller.text.trim())
              .where((text) => text.isNotEmpty) // Opcional: não salvar campos vazios
              .toList();
          widget.onSaved!(finalValues);
        }
      },
      validator: widget.validator,
      initialValue: _selectedValues.whereType<String>().toList(),
      builder: (FormFieldState<List<String>> field) {
        // Função para atualizar o estado do FormField
        void updateState(int index, String value) {
          // Atualizamos tanto o valor selecionado quanto o texto do controller
          _controllers[index].text = value;
          _selectedValues[index] = value;
          // Notificamos o FormField sobre a mudança, filtrando valores nulos
          field.didChange(_selectedValues.whereType<String>().toList());
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(), // Considere adicionar um `Theme.of(context).textTheme...`
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
                      // Ocorre quando uma sugestão é selecionada
                      updateState(index, selection);
                    },
                    // --- AQUI ESTÁ A MÁGICA ---
                    // Ocorre quando o usuário submete o campo (Enter)
                    // ou quando o campo perde o foco.
                    onSubmitted: (String value) { // <-- ALTERADO
                      updateState(index, value);
                    },
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
              ),
              if (field.hasError)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                  child: Text(
                    field.errorText!,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}