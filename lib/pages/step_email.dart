import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_example/bloc/email/email_bloc.dart';
import 'package:stream_example/pages/step_name.dart';
import 'package:stream_example/widgets/flat_button.dart';

class StepEmail extends StatelessWidget {
  const StepEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Step 1'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BlocBuilder<EmailBloc, EmailState>(
              builder: (context, state) {
                return TextField(
                  onChanged: (email) =>
                      context.read<EmailBloc>().add(EmailChanged(email)),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Enter Email',
                    hintText: 'Please enter your email',
                    border: const OutlineInputBorder(),
                    errorText: !state.isEmailValid ? 'Invalid email' : null,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<EmailBloc, EmailState>(
              buildWhen: (previous, current) =>
                  previous.isEmailValid != current.isEmailValid,
              builder: (context, state) {
                return FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StepName(),
                        ),
                      );
                    },
                    text: 'Next',
                    isActive: state.isEmailValid);
              },
            ),
          ],
        ),
      ),
    );
  }
}
