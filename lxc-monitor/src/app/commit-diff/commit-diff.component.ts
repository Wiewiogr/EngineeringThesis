import { Component, OnInit, Inject } from '@angular/core';
import { CommitsService } from '../commits.service';
import {Diff2Html} from 'diff2html';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { MatDialogRef } from '@angular/material/dialog';


@Component({
  selector: 'app-commit-diff',
  templateUrl: './commit-diff.component.html',
  styleUrls: ['./commit-diff.component.css']
})
export class CommitDiffComponent implements OnInit {
  outputHtml: string;

  constructor(
    public dialogRef: MatDialogRef<CommitDiffComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private commitsService: CommitsService
  ) {}

  ngOnInit() {
    this.getDiff(this.data.userName, this.data.commitId);
  }

  showDiff(diff: string) {
    const outputHtml = Diff2Html.getPrettyHtml(diff, {inputFormat: 'diff', showFiles: false, matching: 'lines'});
    this.outputHtml = outputHtml;
  }

  getDiff(userName: string, id: string) {
    this.commitsService.getDiff(userName, id)
    .subscribe(diff => this.showDiff(diff));
  }

  onNoClick(): void {
    this.dialogRef.close();
  }
}
