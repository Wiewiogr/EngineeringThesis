import { Component, OnInit } from '@angular/core';
import { UserService } from '../user.service';
import { User } from '../user';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent implements OnInit {

  users: User[] = [];

  constructor(private userService: UserService) {

  }

  ngOnInit() {
    this.getUsers();
  }

  getUsers(): void {
    this.userService.getUsers()
    .subscribe(users => this.users = users );
  }

  delete(user: User): void {
    this.users = this.users.filter(h => h !== user);
    this.userService.deleteUser(user).subscribe();
  }

  addUser(name: string, password: string) {
    this.users.push({ name: name, isConnected: false, container: 'Running'});
    this.userService.createUser(name, password).subscribe();
  }

  saveSnapshot(path: string) {
    this.userService.saveSnapshot(path).subscribe(msg => console.log('udalo sie'));
  }

  startContainer(name: string) {
    this.userService.startContainer(name).subscribe(response => this.getUsers());
  }

  stopContainer(name: string) {
    this.userService.stopContainer(name).subscribe(response => this.getUsers());
  }
}
