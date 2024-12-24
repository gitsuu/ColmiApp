import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart'; // Soporte para localización

class Calendario extends StatefulWidget {
  const Calendario({super.key});

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _lastTappedDay;
  int _tapCount = 0;

  // Sample event data (replace with your actual data)
  final Map<DateTime, List<Event>> _events = {
    DateTime.now(): [Event('Evento 1')],
    DateTime.now().add(const Duration(days: 1)): [Event('Evento 2')],
    DateTime.now().add(const Duration(days: 3)): [Event('Evento 3')],
  };

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void _addEvent(DateTime day) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController eventController = TextEditingController();
        return AlertDialog(
          title: const Text('Agregar recordatorio'),
          content: TextField(
            controller: eventController,
            decoration: const InputDecoration(hintText: 'Escribe tu nota aquí'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (_events[day] != null) {
                    _events[day]!.add(Event(eventController.text));
                  } else {
                    _events[day] = [Event(eventController.text)];
                  }
                });
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _handleDayTap(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      if (_lastTappedDay == selectedDay) {
        _tapCount++;
      } else {
        _tapCount = 1;
      }
      _lastTappedDay = selectedDay;

      if (_tapCount == 2) {
        _addEvent(selectedDay);
        _tapCount = 0; // Reset tap count after double-click
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting(
        'es_ES'); // Inicializa los datos de localización en español
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            TableCalendar(
              locale: 'es_ES', // Localización en español
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: _handleDayTap,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              eventLoader: _getEventsForDay, // Add event loader
            ),
            const SizedBox(height: 8.0),
            // Display events for selected day
            Expanded(
              child: ListView(
                children: _getEventsForDay(_selectedDay ?? DateTime.now())
                    .map((event) => ListTile(
                          title: Text(event.title),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Simple event class
class Event {
  final String title;

  Event(this.title);
}
