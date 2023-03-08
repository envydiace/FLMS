import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { LeagueDetail, LeagueListbyUser } from './../../models/league-detail.model';
import { LeagueList } from './../../models/league-list.model';
import { LeagueDetailResponse } from './../../models/league-detail-response.model';
import { MatchScheduleResponse } from './../../models/match-schedule-response.model';
import { ClubList } from 'src/app/models/club-list.model';
import { token } from 'src/app/models/token.model';
import { Router } from '@angular/router';
import { ClubListByLeagueResponse } from './../../models/club-list-by-league-response.model'

@Injectable({
  providedIn: 'root'
})

export class LeagueService {
  private headers: HttpHeaders;
  token: token;

  private httpOptions = {
    headers: new HttpHeaders({
      'Content-Type': 'application/json',
      // Authorization: 'my-auth-token'

    }),
  };

  constructor(
    private http: HttpClient,
    private router: Router,

  ) {
    this.token = JSON.parse(localStorage.getItem('user'));
    if(this.token != null) this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);

  }

  public getLeagueInfo(
    leagueId: number
  ): Observable<LeagueDetailResponse> {
    return this.http.get<any>(`${environment.apiUrl}/api/League/GetListLeagueInfo/${leagueId}`);
  }

  public getLeagueList(): Observable<LeagueList> {
    return this.http.get<any>(`${environment.apiUrl}/api/League/GetListLeagueFilters`);
  }

  getmatch(leagueId: number): Observable<MatchScheduleResponse> {
    let params = new HttpParams();

    params = params.append("leagueId", String(leagueId))

    return this.http.get<any>(`${environment.apiUrl}/api/Match/GetLeagueSchedule`, { params }).pipe(
      map((res: MatchScheduleResponse) => res),
      catchError(err => throwError(err))
    )
  }

  findbyUserId(): Observable<LeagueListbyUser[]> {

    return this.http.get<any>(`${environment.apiUrl}/api/League/GetListLeagueByUser`, { headers: this.headers }).pipe(
      map((LeagueListbyUser: LeagueListbyUser[]) => LeagueListbyUser),
      catchError(err => throwError(err))
    )
  }

  sendRegistration(leagueId: number, clubId: number) {
    let body = {
      leagueId,
      clubId
    }
    return this.http.post(`${environment.apiUrl}/api/Request/SendRegistration`, body, { headers: this.headers })
  }


  findClubByLeague(
    leagueId: string,
    clubName: string
    ): Observable<ClubListByLeagueResponse> {
   
    let params = new HttpParams();

    params = params.append('LeagueId', (leagueId));
    params = params.append('SearchName', clubName);

    return this.http.get<any>(`${environment.apiUrl}/api/Participation/GetClubByLeague/`, {params} ).pipe(
      map((res: ClubListByLeagueResponse) => res),
      catchError(err => throwError(err))
    )
  }



}
