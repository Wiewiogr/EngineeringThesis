import { Component, OnInit, Inject } from '@angular/core';
import {MatDialogModule} from '@angular/material/dialog';
import { MatDialogRef } from '@angular/material/dialog';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { FilesService } from '../files.service';

@Component({
  selector: 'app-file-content-modal',
  templateUrl: './file-content-modal.component.html',
  styleUrls: ['./file-content-modal.component.css']
})
export class FileContentModalComponent implements OnInit {
  content: string;

  constructor(
    public dialogRef: MatDialogRef<FileContentModalComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private service: FilesService,
  ) {

  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  ngOnInit() {
    this.service.getFileContent(this.data.userName, this.data.fileName, this.data.commitId)
    .subscribe(content => this.content = content);
  }

}
