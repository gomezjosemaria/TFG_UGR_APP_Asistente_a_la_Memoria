import 'package:flutter/material.dart';
import 'package:flutter_asistente_memoria/bloc/edit_item/edit_item_bloc.dart';
import 'package:flutter_asistente_memoria/model/item_model.dart';
import 'package:flutter_asistente_memoria/screens/shopping_list/shopping_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';


class EditItemForm extends StatelessWidget {

  final ItemModel itemModel;

  const EditItemForm({Key? key, required this.itemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _EditItemNameInput(),
        SizedBox(
          width: double.infinity,
          height: 10.0,
        ),
        _EditItemButton(itemModel: itemModel),
      ],
    );
  }
}

class _EditItemButton extends StatelessWidget {
  final ItemModel itemModel;

  const _EditItemButton({Key? key, required this.itemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditItemBloc, EditItemState>(
      listenWhen: (previous, current) =>
      previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShoppingList()));
        }
      },
      buildWhen: (previous, current) =>
      previous.status != current.status,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: 60.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: StadiumBorder(),
            ),
            onPressed: state.status.isSubmissionInProgress ? null : () {
              context.read<EditItemBloc>().add(EditItemSubmitted(itemModel));
            },
            child: state.status.isSubmissionInProgress
                ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                : Text("Guardar cambios"),
          ),
        );
      },
    );
  }
}

class _EditItemNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Nota',
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<EditItemBloc, EditItemState>(
            builder: (context, state) {
              TextEditingController _controller = TextEditingController();
              _controller.value = TextEditingValue(text: state.nameInput.value);
              var cursorPos = _controller.selection;
              if (cursorPos.start > _controller.text.length) {
                cursorPos = TextSelection.fromPosition(TextPosition(offset: _controller.text.length));
              }
              _controller.selection = cursorPos;
              return TextField(
                key: const Key('editItemForm_textInput_textField'),
                onChanged: (nameInput) => context.read<EditItemBloc>().add(EditItemNameChanged(nameInput)),
                controller: new TextEditingController.fromValue(new TextEditingValue(text: state.nameInput.value, selection: new TextSelection.collapsed(offset: state.nameInput.value.length))),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                  ),
                  hintText: "Redacta la nota aquí",
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