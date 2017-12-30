import { Injectable } from '@angular/core';
import { of } from 'rxjs/observable/of';
import { Commit } from './commit';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs/Observable';
import { catchError } from 'rxjs/operators';

const COMMITS: Commit[] = [
  {id: 'sdfasdafskd123lkjsdfnlk312', fileName: 'fileName', date: '15:24', message: 'CREATE'},
  {id: 'sdflkanxcvoiqweq2132efwr23', fileName: 'fileName', date: '15:24', message: 'MODIFY'},
  {id: 'u217eh128hdsfj00908hje2sdf', fileName: 'fileName', date: '15:25', message: 'MODIFY'},
  {id: '821uw010vcs09viw0efiok320r', fileName: 'fileName', date: '15:26', message: 'DELETE'},
];

const COMMIT_DIFF: string = 'diff --git a\/src\/BookARoom.Domain\/project.json b\/src\/BookARoom.Domain\/projec' +
't.json\r\nindex 864b9a5..8727a9a 100644\r\n--- a\/src\/BookARoom.Do' +
'main\/project.json\r\n+++ b\/src\/BookARoom.Domain\/project.json\r\n@@ -2' +
',7 +2,7 @@\r\n   \"version\": \"1.0.0-*\",\r\n\r\n   \"dependencies\": {\r\n-    \"NETStanda' +
'rd.Library\": \"1.6.0\"\r\n+    \"NETStandard.Library\": \"2.0.0\"\r\n   },\r\n\r\n   \"frameworks\": {';


@Injectable()
export class CommitsService {

  constructor(
    private httpClient: HttpClient
  ) { }

  getCommits(userName: string, from: number, to: number, file: string ): Observable<Commit[]> {
    if (file === '' ) {
      if (from === 0) {
        const url = 'http://localhost:5000/user/' + userName + '/commits';
        return this.httpClient.get<Commit[]>(url).pipe(
          catchError(this.handleError<Commit[]>('getCommits', []))
        );
      } else if (to === 0) {
        const url = 'http://localhost:5000/user/' + userName + '/commits/from/' + from;
        return this.httpClient.get<Commit[]>(url).pipe(
          catchError(this.handleError<Commit[]>('getCommits', []))
        );
      } else {
        const url = 'http://localhost:5000/user/' + userName + '/commits/from/' + from + '/to/' + to;
        return this.httpClient.get<Commit[]>(url).pipe(
          catchError(this.handleError<Commit[]>('getCommits', []))
        );
      }
    } else {
      if (from === 0) {
        const url = 'http://localhost:5000/user/' + userName + '/file/' + btoa(file) + '/commits';
        return this.httpClient.get<Commit[]>(url).pipe(
          catchError(this.handleError<Commit[]>('getCommits', []))
        );
      } else if (to === 0) {
        const url = 'http://localhost:5000/user/' + userName + '/file/' + btoa(file) + '/commits/from/' + from;
        return this.httpClient.get<Commit[]>(url).pipe(
          catchError(this.handleError<Commit[]>('getCommits', []))
        );
      } else {
        const url = 'http://localhost:5000/user/' + userName + '/file/' + btoa(file) + '/commits/from/' + from + '/to/' + to;
        return this.httpClient.get<Commit[]>(url).pipe(
          catchError(this.handleError<Commit[]>('getCommits', []))
        );
      }
    }
    // return of(COMMITS);
  }

  getDiff(userName: string, id: string): Observable<string> {
    // '/user/<name>/commit/id/<id>';
    const url = 'http://localhost:5000/user/' + userName + '/commit/id/' + id;
    return this.httpClient.get<string>(url).pipe(
      catchError(this.handleError<string>('getCommits', ''))
    );
    // return of(COMMIT_DIFF);
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
