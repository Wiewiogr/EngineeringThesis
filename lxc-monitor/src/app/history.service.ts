import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { HistoryLine } from './history-line';
import { of } from 'rxjs/observable/of';
import { Observable } from 'rxjs/Observable';
import { catchError } from 'rxjs/operators';

const HISTORY: HistoryLine[] = [
  {terminal: '/pty/tty0', time: new Date(), line: 'ls'},
  {terminal: '/pty/tty18', time: new Date(), line: 'vim a'},
  {terminal: '/pty/tty1', time: new Date(), line: 'bash a'},
];

@Injectable()
export class HistoryService {

  constructor(
    private httpClient: HttpClient
  ) { }

  getHistory(userName: string, from: number, to: number ): Observable<HistoryLine[]> {
    if (from === 0) {
      return this.httpClient.get<HistoryLine[]>('http://localhost:5000/user/' + userName + '/history').pipe(
        catchError(this.handleError<HistoryLine[]>('getHistory', []))
      );
    } else if (to === 0) {
      return this.httpClient.get<HistoryLine[]>('http://localhost:5000/user/' + userName + '/history/from/' + from).pipe(
        catchError(this.handleError<HistoryLine[]>('getHistory', []))
      );
    } else {
      return this.httpClient.get<HistoryLine[]>('http://localhost:5000/user/' + userName + '/history/from/' + from + '/to/' + to).pipe(
        catchError(this.handleError<HistoryLine[]>('getHistory', []))
      );
    }
    // return of(HISTORY);
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
