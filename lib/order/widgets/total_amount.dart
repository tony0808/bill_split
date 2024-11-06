import 'package:bill_split/order/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalAmount extends StatelessWidget {
  const TotalAmount({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
      return Container(
        //decoration: BoxDecoration(border: Border.all()),
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: Text(
          '\$${state.order.total}',
          style: GoogleFonts.moul(
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      );
    });
  }
}
