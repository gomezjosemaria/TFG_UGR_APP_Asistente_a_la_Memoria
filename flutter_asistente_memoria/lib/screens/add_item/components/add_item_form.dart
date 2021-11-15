import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/add_item/add_item_bloc.dart';
import 'package:flutter_asistente_memoria/screens/shopping_list/shopping_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';


class AddItemForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AddItemNameInput(),
        SizedBox(
          width: double.infinity,
          height: 10.0,
        ),
        _AddItemButton(),
      ],
    );
  }
}

class _AddItemNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Producto',
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
          width: 50,
        ),
        BlocBuilder<AddItemBloc, AddItemState>(
            builder: (context, state) {
              return TextField(
                key: const Key('addItemForm_textInput_textField'),
                onChanged: (textInput) => context.read<AddItemBloc>().add(AddItemNameChanged(textInput)),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                  ),
                  hintText: "Introduce el nombre del producto",
                ),
                keyboardType: TextInputType.multiline,
                minLines: 10,
                maxLines: 10,
              );
            }
        ),
      ],
    );
  }
}

class _AddItemButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddItemBloc, AddItemState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ShoppingList()));
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state.status.isSubmissionInProgress
                ? null
                : () {
              context
                  .read<AddItemBloc>()
                  .add(const AddItemSubmitted());
            },
            child: state.status.isSubmissionInProgress
                ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : Text("Guardar"),
          ),
        );
      },
    );
  }
}