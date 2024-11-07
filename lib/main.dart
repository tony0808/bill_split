import 'package:bill_split/dashboard/bloc/dashboard_bloc.dart';
import 'package:bill_split/group/bloc/group_bloc.dart';
import 'package:bill_split/home.dart';
import 'package:bill_split/order/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  const primaryColor = Color.fromARGB(255, 57, 142, 145);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<DashboardBloc>(
          create: (BuildContext context) => DashboardBloc(),
        ),
        BlocProvider<OrderBloc>(
          create: (BuildContext context) => OrderBloc(),
        ),
        BlocProvider<GroupBloc>(
          create: (BuildContext context) => GroupBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          appBarTheme: AppBarTheme(
            backgroundColor: primaryColor,
            titleTextStyle: GoogleFonts.rowdies(
              color: Colors.white,
              fontSize: 48,
            ),
            centerTitle: true,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
          ),
        ),
        home: const Home(),
      ),
    ),
  );
}
