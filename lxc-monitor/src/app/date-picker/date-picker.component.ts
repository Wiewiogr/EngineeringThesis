import { Component, OnInit } from '@angular/core';
import { DatepickerOptions } from 'ng2-datepicker';

@Component({
  selector: 'app-date-picker',
  templateUrl: './date-picker.component.html',
  styleUrls: ['./date-picker.component.css']
})
export class DatePickerComponent implements OnInit {
  date: Date = new Date();
  from = '';
  to = '';

  options: DatepickerOptions = {
    minYear: 1970,
    maxYear: 2030,
    displayFormat: 'MMM D[,] YYYY',
    barTitleFormat: 'MMMM YYYY',
    firstCalendarDay: 0, // 0 - Sunday, 1 - Monday
    // minDate: new Date(Date.now()), // Minimal selectable date
    // maxDate: new Date(Date.now())  // Maximal selectable date
  };

  constructor() { }

  ngOnInit() {
  }

  getFromInEpoch() {
    if ( this.from.includes(':')) {
      const splittedArray = this.from.split(':');
      const hour = splittedArray[0];
      const minute = splittedArray[1];
      const date = this.date;
      date.setHours(+hour);
      date.setMinutes(+minute);
      return date.getTime(); // / 1000;
    } else {
      return 0;
    }
  }

  getToInEpoch() {
    if ( this.to.includes(':')) {
      const splittedArray = this.to.split(':');
      const hour = splittedArray[0];
      const minute = splittedArray[1];
      const date = this.date;
      date.setHours(+hour);
      date.setMinutes(+minute);
      return date.getTime(); // / 1000;
    } else {
      return 0;
    }
  }

}
