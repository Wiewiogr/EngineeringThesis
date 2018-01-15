import { Injectable } from '@angular/core';
import { Observable } from 'rxjs/Observable';
import { of } from 'rxjs/observable/of';
import { User } from './user';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { catchError, map, tap } from 'rxjs/operators';

const USERS: User[] = [
  {name: 'user1', isConnected: true},
  {name: 'user2', isConnected: false},
];

const httpOptions = {
  headers: new HttpHeaders(
    {
      'Content-Type': 'application/json'
    }
  )
};

@Injectable()
export class UserService {

  private url = 'http://localhost:5000/';

  constructor(
    private httpClient: HttpClient
  ) {}

  getUsers(): Observable<User[]> {
    return this.httpClient.get<User[]>(this.url + 'user').pipe(
      catchError(this.handleError<User[]>('getUsers', []))
    );
  }

  deleteUser(user: User) {
    return this.httpClient.delete(this.url + 'user/' + user.name, httpOptions).pipe(
      catchError(this.handleError('deleteUser', null))
    );
  }

  createUser(name: string, password: string) {
    return this.httpClient.post(this.url + 'user', { username: name, password: password}, httpOptions).pipe(
      catchError(this.handleError('createUser', null))
    );
  }

  saveSnapshot(path: string) {
    return this.httpClient.post(this.url + 'user/snapshot', { path: path}, httpOptions).pipe(
      catchError(this.handleError('saveSnapshot', null))
    );
  }

  private handleError<T> (operation = 'operation', result?: T) {
    return (error: any): Observable<T> => {

      // TODO: send the error to remote logging infrastructure
      console.error(error); // log to console instead

      // TODO: better job of transforming error for user consumption
      console.log(`${operation} failed: ${error.message}`);

      // Let the app keep running by returning an empty result.
      return of(result as T);
    };
  }

}
