import { Component, OnInit } from '@angular/core';
import { CommitsService } from '../commits.service';
import {Diff2Html} from 'diff2html';


@Component({
  selector: 'app-commit-diff',
  templateUrl: './commit-diff.component.html',
  styleUrls: ['./commit-diff.component.css']
})
export class CommitDiffComponent implements OnInit {
  outputHtml: string;

  constructor(
    private commitsService: CommitsService
  ) {}

  ngOnInit() {
  }

  showDiff(diff: string) {
    const outputHtml = Diff2Html.getPrettyHtml(diff, {inputFormat: 'diff', showFiles: false, matching: 'lines'});
    this.outputHtml = outputHtml;
  }

  getDiff(userName: string, id: string) {
    this.commitsService.getDiff(userName, id)
    .subscribe(diff => this.showDiff(diff));
  }

}
