import 'package:apple_store/bloc/comment/comment-bloc.dart';
import 'package:apple_store/di/di.dart';
import 'package:apple_store/widgets/loading-animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasource/product-detail-datasource.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              BlocProvider(
                create: (context) {
                  var bloc = CommentBloc();
                  bloc.add(CommentInitialRequestEvent('0dm39wc0lcd0ezu'));
                  return bloc;
                },
                child: BlocBuilder<CommentBloc, CommentState>(
                  builder: (context, state) {
                    if (state is CommentLoadingState) {
                      return LoeadingAnimation();
                    } else if (state is CommentResponseState) {
                      return state.comments.fold(
                        (l) {
                          return Text(l);
                        },
                        (r) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return Text(r[index].text);
                            },
                            itemCount: r.length,
                          );
                        },
                      );
                    } else {
                      return Text('error');
                    }
                  },
                ),
              );
            },
            child: Text('tap'),
          ),
        ),
      ),
    );
  }
}

class TestScreen2 extends StatefulWidget {
  const TestScreen2({super.key});

  @override
  State<TestScreen2> createState() => _TestScreen2State();
}

class _TestScreen2State extends State<TestScreen2>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: 1,
      ),
      value: 1.0,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
            child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.abc_outlined),
                label: Text('ali'))),
      ),
    );
  }
}

class TestScreen3 extends StatelessWidget {
  const TestScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: ElevatedButton(
              onPressed: () async {
                final IProductDetailDatasource data = locatore.get();
                var varint = await data.getVariants('tghqmae45p95sju');
                varint.forEach((element) {
                  print(element.value);
                });
              },
              child: Text('tap'),
            ),
          ),
        ),
      ),
    );
  }
}
