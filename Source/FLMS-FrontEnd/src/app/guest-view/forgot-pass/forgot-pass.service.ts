import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Router } from '@angular/router';
import { environment } from '../../../environments/environment';
import { map, catchError } from 'rxjs/operators';
import { Observable, throwError } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ForgotPassService {

  constructor(
    private http: HttpClient,
    private router: Router,
  ) { }

  getEmailForgotPassword(email: string): Observable<any> {
    let params = new HttpParams();
    params = params.append('email', email);
    return this.http.post(`${environment.apiUrl}/api/ForgotPass`, null, { params });
  }

  ChangePassword(body: any): Observable<any> {
    return this.http.post(`${environment.apiUrl}/api/ChangeNewPass`,body );
  }

}
