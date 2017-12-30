import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { UsersComponent } from './users/users.component';
import { HistoryComponent } from './history/history.component';
import { CommitsComponent } from './commits/commits.component';
import { FilesComponent } from './files/files.component';

const routes: Routes = [
  { path: '', redirectTo: '/users', pathMatch: 'full' },
  { path: 'users', component: UsersComponent },
  { path: 'dupa', component: UsersComponent },
  { path: 'history/:user', component: HistoryComponent },
  { path: 'files/:user', component: FilesComponent },
  { path: 'commits/:user', component: CommitsComponent },
  { path: 'commits/:user/:file', component: CommitsComponent }
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule {}
