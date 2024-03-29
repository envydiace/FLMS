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
import { ClubListByLeagueResponse } from './../../models/club-list-by-league-response.model';
import { LeagueFeeResponse } from './../../models/fee-response.model';
import { MatchEvent } from './../../models/match-event-detail.model';
import { leagueFee } from 'src/app/models/league-prize.model';
import { createLeagueInfo } from 'src/app/models/create-league-info.model';
import { LeagueStatisticResponse } from '../../models/league-statistics-response.model';
import { LeagueStatisticTypeKO } from 'src/app/models/league-statistic-type-ko.model';

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
    if (this.token != null) this.headers = new HttpHeaders().set('Authorization', `Bearer ${this.token.accessToken}`);

  }

  public getLeagueInfo(
    leagueId: number
  ): Observable<LeagueDetailResponse> {
    return this.http.get<any>(`${environment.apiUrl}/api/League/GetListLeagueInfo/${leagueId}`);
  }

  public getLeagueList(): Observable<LeagueList> {
    return this.http.get<any>(`${environment.apiUrl}/api/League/GetListLeagueFilters`);
  }

  getmatch(
    leagueId: number,
    from: string,
    to: string,
    clubName: string
  ): Observable<MatchScheduleResponse> {
    let params = new HttpParams();

    params = params.append("leagueId", String(leagueId));
    params = params.append('from', from);
    params = params.append('to', to);
    params = params.append('searchClubName', clubName);

    return this.http.get<any>(`${environment.apiUrl}/api/Match/GetLeagueSchedule`, { params }).pipe(
      map((res: MatchScheduleResponse) => res),
      catchError(err => throwError(err))
    );
  }

  findbyUserId(): Observable<LeagueListbyUser[]> {

    return this.http.get<any>(`${environment.apiUrl}/api/League/GetListLeagueByUser`, { headers: this.headers }).pipe(
      map((LeagueListbyUser: LeagueListbyUser[]) => LeagueListbyUser),
      catchError(err => throwError(err))
    )
  }

  sendRegistration(leagueId: number, clubId: number): Observable<any> {
    let body = {
      leagueId,
      clubId
    }
    return this.http.post(`${environment.apiUrl}/api/Request/SendRegistration`, body, { headers: this.headers })
  }

  findAll(page: number, size: number): Observable<any> {
    let params = new HttpParams();

    params = params.append('page', String(page));
    params = params.append('pageSize', String(size));

    return this.http.get<any>(`${environment.apiUrl}/api/League/GetListLeagueFilters`, { params }).pipe(map((leagueList: LeagueList) => leagueList),
      catchError(err => throwError(err))
    )
  }

  findListLeagueFilter(
    leagueName: string,
    page: number,
    size: number,
    from: string,
    to: string
  ): Observable<any> {
    let params = new HttpParams();
    params = params.append('searchLeagueName', leagueName);
    params = params.append('page', String(page));
    params = params.append('size', String(size));
    params = params.append('from', from);
    params = params.append('to', to);

    return this.http.get<any>(`${environment.apiUrl}/api/League/GetListLeagueFilters`, { params })
  }


  findClubByLeague(
    leagueId: string,
    clubName: string
  ): Observable<ClubListByLeagueResponse> {

    let params = new HttpParams();

    params = params.append('LeagueId', (leagueId));
    params = params.append('SearchName', clubName);

    return this.http.get<any>(`${environment.apiUrl}/api/Participation/GetClubByLeague/`, { params }).pipe(
      map((res: ClubListByLeagueResponse) => res),
      catchError(err => throwError(err))
    )
  }

  getLeagueFee(leagueId: number): Observable<LeagueFeeResponse> {
    let params = new HttpParams();

    params = params.append("leagueId", String(leagueId))

    return this.http.get<any>(`${environment.apiUrl}/api/Fee/GetLeagueFees`, { params }).pipe(
      map((res: LeagueFeeResponse) => res),
      catchError(err => throwError(err))
    )
  }

  getMatchEvent(matchId: number): Observable<MatchEvent[]> {
    return this.http.get<any>(`${environment.apiUrl}/api/Event/GetMatchEvent/${matchId}`,).pipe(
      map((res: MatchEvent[]) => res),
      catchError(err => throwError(err))
    )
  }

  createLeague(league: createLeagueInfo): Observable<any> {
    return this.http.post(`${environment.apiUrl}/api/League/CreateLeague`, league, { headers: this.headers });
  }

  getLeagueStatistics(leagueId: number): Observable<LeagueStatisticResponse> {
    return this.http.get(`${environment.apiUrl}/api/League/GetLeagueStatistic/${leagueId}`).pipe(map((res: LeagueStatisticResponse) => res),
      catchError(err => throwError(err)));
  }

  exportLeagueSchedule(leagueId: number): Observable<any> {
    return this.http.get(`${environment.apiUrl}/api/Export/ExporLeagueSchedule/${leagueId}`, { responseType: 'arraybuffer' });
  }

  getLeagueStatisticTypeKO(leagueId: number): Observable<LeagueStatisticTypeKO> {
    return this.http.get(`${environment.apiUrl}/api/League/GetKnockOutStatistic/${leagueId}`).pipe(map((res: LeagueStatisticTypeKO) => res),
      catchError(err => throwError(err)));
  }
}
