import { Injectable } from '@angular/core';
import { Router } from '@angular/router';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { BehaviorSubject, Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { User } from '../models/user';
import { UserProfileResponse } from '../models/user-profile-response.model';
import { environment } from 'src/environments/environment';
import { UserProfile } from '../models/user-profile.model';
import { token } from '../models/token.model';
import jwt_decode from "jwt-decode";

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private headers: HttpHeaders;
  token: token;

  // store the URL so we can redirect after logging in
  public redirectUrl: string;

  public user: Observable<User>;
  private userSubject: BehaviorSubject<User>;

  constructor(
    private http: HttpClient,
    private router: Router
  ) {
    this.token = JSON.parse(localStorage.getItem('user'));
    if (this.token != null) this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);
    this.userSubject = new BehaviorSubject<User>(JSON.parse(localStorage.getItem('user') || '{}'));
    this.user = this.userSubject.asObservable();
  }

  public get userValue(): User {
    return this.userSubject.value;
  }

  login(email, password): Observable<boolean> {
    return this.http.post<User>(`${environment.apiUrl}/api/Login`, { email, password })
      .pipe(map(user => {
        localStorage.setItem('user', JSON.stringify(user));
        return true;
      }));
  }

  logout() {
    return this.http.post<any>(`${environment.apiUrl}/api/Logout`, null, { headers: this.headers }).subscribe(
      (response) => {
        localStorage.removeItem('user');
        this.userSubject.next(null as any);
        window.location.href = environment.localUrl;
        return response;
      }
    );
  }

  getCurrentUser(): Observable<UserProfileResponse> {
    return this.http.get<UserProfileResponse>(`${environment.apiUrl}/api/GetUserProfile`, { headers: this.headers }).pipe(
      map((res: UserProfileResponse) => res)
    );
  }

  getUserRole() {
    if (this.token != null) {
      this.token = JSON.parse(localStorage.getItem('user'));
      const decodedToken = jwt_decode(this.token.accessToken);
      const role = (decodedToken as { role: string }).role;
      return role;
    } else {
      return null;
    }
  }

  getUserId() {
    if (this.token != null) {
      this.token = JSON.parse(localStorage.getItem('user'));
      const decodedToken = jwt_decode(this.token.accessToken);
      const nameid = (decodedToken as { nameid: string }).nameid;
      return nameid;
    } else {
      return null;
    }
  }

  public getAccessToken(): string {
    return localStorage.getItem('user');
  }

  public isLoggedIn(): boolean {
    const token = this.getAccessToken();
    return token !== null;
  }
}
