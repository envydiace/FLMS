import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { UserProfileResponse } from './../../models/user-profile-response.model';
import { token } from './../../models/token.model';
import { map, catchError } from 'rxjs/operators';
import { UserProfile } from 'src/app/models/user-profile.model';
import { User } from 'src/app/models/user';

@Injectable({
  providedIn: 'root'
})

export class ProfileService {
  private headers: HttpHeaders;
  token: token;
  userId: number;

  constructor(
    private http: HttpClient
  ) {
    this.token = JSON.parse(localStorage.getItem('user')!);
    if (this.token != null) this.headers = new HttpHeaders().set('Authorization',
      `Bearer ${this.token.accessToken}`);


  }

  getuserprofile(): Observable<UserProfileResponse> {
    return this.http.get<any>(`${environment.apiUrl}/api/GetUserProfile`,
      { headers: this.headers }).pipe(
        map((res: UserProfileResponse) => res)
      )
  }
  editProfile(user: UserProfile): Observable<any> {
    return this.http.put(`${environment.apiUrl}/api/EditProfile`, user, { headers: this.headers });
  }

  changePassword(
    body: any
  ): Observable<any> {
    return this.http.put(`${environment.apiUrl}/api/ChangePassword`, body, { headers: this.headers });
  }

}
