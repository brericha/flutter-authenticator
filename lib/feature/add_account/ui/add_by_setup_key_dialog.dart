import 'package:authenticator/feature/add_account/data/add_by_setup_key_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddBySetupKeyDialog extends StatefulWidget {
  const AddBySetupKeyDialog({Key? key}) : super(key: key);

  @override
  State<AddBySetupKeyDialog> createState() => _AddBySetupKeyDialogState();
}

class _AddBySetupKeyDialogState extends State<AddBySetupKeyDialog> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController _titleController = TextEditingController(),
      _secretController = TextEditingController();

  final cubit = AddBySetupKeyCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit,
      child: BlocBuilder<AddBySetupKeyCubit, AddBySetupKeyState>(
        builder: (_, state) {
          if (state is AccountAddSuccessful) {
            Navigator.of(context).pop(state.id);
            return Container();
          } else {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Add Account', style: TextStyle(fontSize: 32),),
                  FormBuilder(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: 'title',
                          autofocus: true,
                          controller: _titleController,
                          decoration: const InputDecoration(
                              labelText: 'Title'
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'This field is required')
                          ]),
                        ),
                        FormBuilderTextField(
                          name: 'secret',
                          controller: _secretController,
                          decoration: const InputDecoration(
                              labelText: 'Setup Key'
                          ),
                          obscureText: true,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: 'This field is required')
                          ]),
                        ),
                        TextButton(
                          onPressed: () {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              cubit.onSubmit(
                                  _titleController.text,
                                  _secretController.text);
                            }
                          },
                          child: const Text('Submit'),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
