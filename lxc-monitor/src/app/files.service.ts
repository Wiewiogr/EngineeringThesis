import { Injectable } from '@angular/core';
import { of } from 'rxjs/observable/of';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs/Observable';
import { catchError } from 'rxjs/operators';

const FILES: string[] = [
  'home/a',
  'home/b',
  'home/c',
  'home/d/a',
  'home/d/b',
];

const FILE_CONTENT: string = 'sdfkdsklfjdklsjfa\n' +
'fkjsdfklalksdjflksjdlkfjalksdjflkadsf\n' +
'sdfkljasdkljfkljsdlfkjskdjflkajslkfj';

@Injectable()
export class FilesService {

  constructor(
    private httpClient: HttpClient
  ) { }

  getFiles(userName: string, commitId: string, prefix: string): Observable<string[]> {
    if (commitId === '') {
      if (prefix === '') {
        return this.httpClient.get<string[]>('http://localhost:5000/user/' + userName + '/files').pipe(
          catchError(this.handleError<string[]>('getFiles', []))
        );
      } else {
        return this.httpClient.get<string[]>('http://localhost:5000/user/' + userName + '/files/prefix/' + btoa(prefix)).pipe(
          catchError(this.handleError<string[]>('getFiles', []))
        );
      }
    } else {
      if (prefix === '') {
        return this.httpClient.get<string[]>('http://localhost:5000/user/' + userName + '/files/commit/id/' + commitId).pipe(
          catchError(this.handleError<string[]>('getFiles', []))
        );
      } else {
        const url = 'http://localhost:5000/user/' + userName + '/files/prefix/' + btoa(prefix) + '/commit/id/' + commitId;
        return this.httpClient.get<string[]>(url).pipe(
          catchError(this.handleError<string[]>('getFiles', []))
        );
      }
    }
  }

  getFileContent(userName: string, fileName: string, commitId: string): Observable<string> {
    if (commitId === '') {
      const url = 'http://localhost:5000/user/' + userName + '/files/name/' + btoa(fileName);
      return this.httpClient.get<string>(url).pipe(
        catchError(this.handleError<string>('getFileContent', ''))
      );
    } else {
      const url = 'http://localhost:5000/user/' + userName + '/files/name/' + btoa(fileName) + '/commit/id/' + commitId;
      return this.httpClient.get<string>(url).pipe(
        catchError(this.handleError<string>('getFileContent', ''))
      );
    }
    // return of(FILE_CONTENT);
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
