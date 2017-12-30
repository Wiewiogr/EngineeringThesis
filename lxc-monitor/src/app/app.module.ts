import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppComponent } from './app.component';
import { UsersComponent } from './users/users.component';
import { UserService } from './user.service';
import { AppRoutingModule } from './/app-routing.module';
import { HistoryComponent } from './history/history.component';
import { HistoryService } from './history.service';
import { DatePickerComponent } from './date-picker/date-picker.component';
import { NgDatepickerModule } from 'ng2-datepicker';
import { CommitsComponent } from './commits/commits.component';
import { CommitsService } from './commits.service';
import { CommitDiffComponent } from './commit-diff/commit-diff.component';
import { FilesComponent } from './files/files.component';
import { FilesService } from './files.service';
import { HttpClientModule } from '@angular/common/http';


@NgModule({
  declarations: [
    AppComponent,
    UsersComponent,
    HistoryComponent,
    DatePickerComponent,
    CommitsComponent,
    CommitDiffComponent,
    FilesComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    NgDatepickerModule,
    HttpClientModule
  ],
  providers: [ UserService, HistoryService, CommitsService, FilesService ],
  bootstrap: [AppComponent]
})
export class AppModule { }
