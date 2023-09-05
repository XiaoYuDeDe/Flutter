abstract class NavigationEvents{
  const NavigationEvents();
}

class TriggerNavigationEvents extends NavigationEvents{
  final int index;
  const TriggerNavigationEvents(this.index):super();
}