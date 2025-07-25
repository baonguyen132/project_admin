import 'package:exchange_book/screens/dashboard/cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../util/responsive.dart';
import 'dashboard_desktop.dart';
import 'dashboard_mobile.dart';
import 'dashboard_tablet.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final DashboardCubit _dashboardCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dashboardCubit = DashboardCubit() ;
    Future.microtask(() => _dashboardCubit.loadingDataUser(),);
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          BlocProvider.value(value: _dashboardCubit)

        ],
      child: BlocBuilder<DashboardCubit, DashboardState >(
        builder: (context, state) {
          return state.isLoading ? const Center(child: CircularProgressIndicator()): Responsive(
              desktop: DashboardDesktop(
                state: state,
                hanlde: (item) {context.read<DashboardCubit>().exchange(item, false) ;},
                child:  state.screen,
              ),
              mobile: DashboardMobile(
                state: state,
                hanlde: (item) {context.read<DashboardCubit>().exchange(item, true) ;},
                child:  state.screen,
              ),
              tablet: DashboardTablet(
                state: state,
                hanlde: (item) {context.read<DashboardCubit>().exchange(item, false) ;},
                child:  state.screen,
              )
          );
        },),
    );
  }
}
