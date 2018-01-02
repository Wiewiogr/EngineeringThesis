import { Component, OnInit, Input, ViewChild } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { HistoryService } from '../history.service';
import { HistoryLine } from '../history-line';
import { User } from '../user';
import { DatePickerComponent } from '../date-picker/date-picker.component';
import { retry } from 'rxjs/operators/retry';

@Component({
  selector: 'app-history',
  templateUrl: './history.component.html',
  styleUrls: ['./history.component.css']
})
export class HistoryComponent implements OnInit {
  @Input() userName: string;
  history: HistoryLine[] = [];
  @ViewChild(DatePickerComponent) datePicker: DatePickerComponent;

  constructor(
    private route: ActivatedRoute,
    private historyService: HistoryService,
  ) {}

  ngOnInit() {
    this.getUser();
  }

  getUser(): void {
    const user = this.route.snapshot.paramMap.get('user');
    this.userName = user;
  }

  getHistory() {
    this.historyService.getHistory(this.userName, this.datePicker.getFromInEpoch(), this.datePicker.getToInEpoch())
    .subscribe(history => this.history = history);
  }

  getTime(time) {
    const date = new Date((+time) * 1000);
    return date;
  }
}
