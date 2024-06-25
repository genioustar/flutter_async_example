import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_example/bloc/email/email_bloc.dart';
import 'package:stream_example/bloc/email/name_bloc.dart';
import 'package:stream_example/bloc/email/password_bloc.dart';
import 'package:stream_example/widgets/flat_button.dart';

class StepPassword extends StatelessWidget {
  const StepPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step Three'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              BlocBuilder<PasswordBloc, PasswordState>(
                builder: (context, state) {
                  return TextField(
                    onChanged: (password) => context
                        .read<PasswordBloc>()
                        .add(PasswordChanged(password)),
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Enter password',
                      hintText: 'Please enter your password',
                      border: OutlineInputBorder(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<PasswordBloc, PasswordState>(
                builder: (context, state) {
                  return TextField(
                    onChanged: (value) => context
                        .read<PasswordBloc>()
                        .add(ConfirmPasswordChanged(value)),
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Confirm password',
                      hintText: 'Please confirm your password',
                      border: OutlineInputBorder(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<PasswordBloc, PasswordState>(
                buildWhen: (previous, current) =>
                    previous.isPasswordValid != current.isPasswordValid ||
                    previous.isConfirmPasswordValid !=
                        current.isConfirmPasswordValid,
                builder: (context, state) {
                  return FlatButton(
                      onPressed: () {
                        context
                            .read<PasswordBloc>()
                            .add(const PasswordSubmitted());
                        context.read<EmailBloc>().add(const EmailSubmitted());
                        context.read<NameBloc>().add(const NameSubmitted());
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                      text: 'Register',
                      isActive: state.isPasswordValid &&
                          state.isConfirmPasswordValid);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
