import { Component, OnInit, ViewChild, Input } from '@angular/core';
import { DatePickerComponent } from '../date-picker/date-picker.component';
import { ActivatedRoute } from '@angular/router';
import { CommitsService } from '../commits.service';
import { Commit } from '../commit';
import { CommitDiffComponent } from '../commit-diff/commit-diff.component';
import { MatDialog } from '@angular/material/dialog';

@Component({
  selector: 'app-commits',
  templateUrl: './commits.component.html',
  styleUrls: ['./commits.component.css']
})
export class CommitsComponent implements OnInit {

  @Input() userName: string;
  @Input() fileName = '';
  @ViewChild(DatePickerComponent) datePicker: DatePickerComponent;
  @ViewChild(CommitDiffComponent) commitDiff: CommitDiffComponent;
  commits: Commit[] = [];

  constructor(
    private route: ActivatedRoute,
    private commitsService: CommitsService,
    public dialog: MatDialog
  ) {}

  ngOnInit() {
    this.getUserAndFile();
  }

  getUserAndFile(): void {
    const user = this.route.snapshot.paramMap.get('user');
    this.userName = user;
    if (this.route.snapshot.paramMap.has('file') ) {
      this.fileName = atob(this.route.snapshot.paramMap.get('file'));
    }
  }

  getCommits() {
    this.commitsService.getCommits(this.userName, this.datePicker.getFromInEpoch(), this.datePicker.getToInEpoch(), this.fileName)
    .subscribe(commits => this.commits = commits);
  }

  getTime(time) {
    const date = new Date((+time) * 1000);
    return date;
  }

  openDialog(commitId: string): void {
    const dialogRef = this.dialog.open(CommitDiffComponent, {
      data: { userName: this.userName, commitId: commitId }
    });

    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
    });
  }

}
