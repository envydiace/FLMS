import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { token } from './../../models/token.model';
import { map, catchError } from 'rxjs/operators';
import { Observable, throwError } from 'rxjs';
import { RequestListResponse } from './../../models/request-list-response.model';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class RequestService {
  private headers: HttpHeaders;
  token: token;

  constructor(
    private http: HttpClient
  ) { 
    this.token = JSON.parse(localStorage.getItem('user')!);
    if(this.token != null) this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);
  }

  public getRequestList(from: string, to: string, type: string, status: string): Observable<RequestListResponse> {
    let params = new HttpParams();

    params = params.append('from', from);
    params = params.append('to', to);
    params = params.append('type', type);
    params = params.append('status', status);

    return this.http.get<any>(`${environment.apiUrl}/api/Request/RequestListFilter`, { params , headers: this.headers });
  }

  public updateRequestStatus(requestId: number, action: string):Observable<any> {
    return this.http.put(`${environment.apiUrl}/api/Request/${action}/${requestId}`, null, { headers: this.headers });
  }
}
