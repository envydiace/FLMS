import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { Observable } from 'rxjs';
import { UserRegister } from '../../models/new-user-model';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { environment } from '../../../environments/environment';


@Injectable({
  providedIn: 'root'
})
export class RegisterService {

  public user: Observable<UserRegister>;
  constructor(
    private router: Router,
    private http: HttpClient
  ) { }
  register(user: UserRegister) {
    return this.http.post(`${environment.apiUrl}/api/Signup`, user)
  }


}
