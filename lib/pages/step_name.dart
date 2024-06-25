import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_example/bloc/email/name_bloc.dart';
import 'package:stream_example/pages/step_password.dart';
import 'package:stream_example/widgets/flat_button.dart';

class StepName extends StatelessWidget {
  const StepName({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step Two'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              BlocBuilder<NameBloc, NameState>(
                builder: (context, state) {
                  return TextField(
                    onChanged: (name) =>
                        context.read<NameBloc>().add(NameChanged(name)),
                    decoration: InputDecoration(
                      labelText: 'Enter name',
                      hintText: 'Please enter your name',
                      border: const OutlineInputBorder(),
                      errorText: !state.isNameValid ? 'Invalid name' : null,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<NameBloc, NameState>(
                buildWhen: (previous, current) =>
                    previous.isNameValid != current.isNameValid,
                builder: (context, state) {
                  return FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StepPassword(),
                          ),
                        );
                      },
                      text: 'Next',
                      isActive: state.isNameValid);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
