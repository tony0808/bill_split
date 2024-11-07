import 'package:bill_split/assignmnet/models/assigned_item.dart';
import 'package:bill_split/dashboard/models/summary_data.dart';
import 'package:bill_split/group/models/person.dart';
import 'package:bill_split/order/models/item.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<DashboardOrderCompletedEvent>(_onOrderCompleted);
    on<DashboardGroupCompletedEvent>(_onGroupCompleted);
    on<DashboardResetEvent>(_onOrderReset);
  }

  void _onOrderCompleted(DashboardOrderCompletedEvent event, Emitter<DashboardState> emit) {
    emit(state.copyWith(status: DashboardStatus.orderCreated));
  }

  void _onGroupCompleted(DashboardGroupCompletedEvent event, Emitter<DashboardState> emit) {
    SummaryData summaryData = getSummaryData(event.foodItems, event.people);
    emit(state.copyWith(status: DashboardStatus.groupCreated, summaryData: summaryData));
  }

  void _onOrderReset(DashboardResetEvent event, Emitter<DashboardState> emit) {
    emit(state.copyWith(status: DashboardStatus.initial));
  }

  SummaryData getSummaryData(List<Item> foodItems, List<Person> people) {
    Map<Item, double> itemPriceMap = getItemPriceMap(foodItems);
    Map<Item, int> itemShareMap = getItemShareMap(people);
    Map<Item, double> costPerShareMap = getCostPerShareMap(itemPriceMap, itemShareMap);
    Map<String, double> debtMap = getPeopleDebtMap(costPerShareMap, people);

    return SummaryData(debtMap: debtMap);
  }

  Map<Item, double> getItemPriceMap(List<Item> foodItems) {
    Map<Item, double> itemPriceMap = {};

    for (Item foodItem in foodItems) {
      itemPriceMap.putIfAbsent(foodItem, () => foodItem.price * foodItem.quantity);
    }

    return itemPriceMap;
  }

  Map<Item, int> getItemShareMap(List<Person> people) {
    Map<Item, int> itemSelectionCountMap = {};

    List<AssignedItem> assignedItems;

    for (Person person in people) {
      assignedItems = person.assignedItems;
      for (AssignedItem assignedItem in assignedItems) {
        if (itemSelectionCountMap.containsKey(assignedItem.item)) {
          itemSelectionCountMap.update(assignedItem.item, (count) => count + assignedItem.quantity);
        } else {
          itemSelectionCountMap.putIfAbsent(assignedItem.item, () => assignedItem.quantity);
        }
      }
    }

    return itemSelectionCountMap;
  }

  Map<Item, double> getCostPerShareMap(Map<Item, double> priceMap, Map<Item, int> shareMap) {
    Map<Item, double> costPerShareMap = {};

    priceMap.forEach((item, price) {
      costPerShareMap.putIfAbsent(item, () => price / shareMap[item]!);
    });

    return costPerShareMap;
  }

  Map<String, double> getPeopleDebtMap(Map<Item, double> costPerShareMap, List<Person> people) {
    Map<String, double> debtMap = {};

    List<AssignedItem> assignedItems;
    double debt;
    Item item;

    for (Person person in people) {
      assignedItems = person.assignedItems;
      debt = 0.0;
      for (AssignedItem assignedItem in assignedItems) {
        item = assignedItem.item;
        debt += costPerShareMap[item]! * assignedItem.quantity;
      }
      debtMap.putIfAbsent(person.name, () => debt);
    }

    return debtMap;
  }
}
