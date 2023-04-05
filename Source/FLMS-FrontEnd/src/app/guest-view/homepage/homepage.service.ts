import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';


@Injectable({
  providedIn: 'root'
})
export class HomepageService {
  private httpOptions = {
    headers: new HttpHeaders ({
      'Content-Type': 'application/json',
      // Authorization: 'my-auth-token'
    }),
  };

  constructor(
    private http: HttpClient
  ) { }

  public getListClubFilter(): Observable<any> {
    return this.http.get<any>(`${environment.apiUrl}/api/Club/GetListClubFilter?page=1&pageSize=5`, this.httpOptions);
  }

  public GetTopLeaguePrize(): Observable<any> {
    return this.http.get<any>(`${environment.apiUrl}/api/League/GetTopLeaguePrize/5`, this.httpOptions);
  }
}
