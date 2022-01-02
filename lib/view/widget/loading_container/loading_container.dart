import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_tv/bloc/loader_bloc/loader_bloc.dart';
import 'package:live_tv/bloc/loader_bloc/loader_state.dart';
import 'package:live_tv/view/widget/loading_widget/loading_widget.dart';

class LoadingContainer extends StatelessWidget {
  final Widget child;

  const LoadingContainer({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        BlocBuilder<LoaderBloc, LoaderState>(
            builder: (context, state) => Visibility(
                visible: state is LoadingState,
                child: Center(child: LoadingWidget())))
      ],
    );
  }
}
