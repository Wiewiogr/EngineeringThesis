import { Component, OnInit, Input } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { MatTableModule } from '@angular/material/table';
import { DataSource } from '@angular/cdk/collections';
import { FilesService } from '../files.service';
import { MatTableDataSource } from '@angular/material/table';
import { FileContentModalComponent } from '../file-content-modal/file-content-modal.component';
import { MatDialog } from '@angular/material/dialog';

@Component({
  selector: 'app-files',
  templateUrl: './files.component.html',
  styleUrls: ['./files.component.css']
})
export class FilesComponent implements OnInit {

  @Input() userName: string;
  files: string[] = [];
  commitId = '';
  filePrefix = '';

  constructor(
    private route: ActivatedRoute,
    private service: FilesService,
    public dialog: MatDialog
  ) {}

  ngOnInit() {
    this.getUser();
  }

  getUser(): void {
    const user = this.route.snapshot.paramMap.get('user');
    this.userName = user;
  }

  getFiles() {
    this.service.getFiles(this.userName, this.commitId, this.filePrefix)
    .subscribe(files => this.files = files);
  }

  encode(str: string) {
    return btoa(str);
  }

  openDialog(fileName: string): void {
    const dialogRef = this.dialog.open(FileContentModalComponent, {
      data: { userName: this.userName, commitId: this.commitId, fileName }
    });

    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
    });
  }
}
