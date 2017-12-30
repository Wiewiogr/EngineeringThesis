import { Component, OnInit, Input } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { FilesService } from '../files.service';

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
  fileContent = '';

  constructor(
    private route: ActivatedRoute,
    private service: FilesService
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

  getFileContent(fileName: string) {
      this.service.getFileContent(this.userName, fileName, this.commitId)
      .subscribe(content => this.fileContent = content);
  }

  encode(str: string) {
    return btoa(str);
  }
}
