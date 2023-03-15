import { Injectable } from '@angular/core';
import { token } from '../../models/token.model';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Router } from '@angular/router';
import { LeagueList } from './../../models/league-list.model';
import { environment } from '../../../environments/environment';
import { LeagueListbyUser } from '../../models/league-detail.model';
import { map, catchError } from 'rxjs/operators';
import { Observable, throwError } from 'rxjs';
import { LeagueDetailResponse } from 'src/app/models/league-detail-response.model';
import { ClubListByLeagueResponse } from 'src/app/models/club-list-by-league-response.model';
import { MatchEvent } from 'src/app/models/match-event-detail.model';
import { FeeDetailResponse, LeagueClubFeeResponse, LeagueFeeResponse } from 'src/app/models/fee-response.model';
import { MatchScheduleResponse } from 'src/app/models/match-schedule-response.model';
import { FeeDetail, LeagueClubFee } from 'src/app/models/fee-detail.model';



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

  getListLeagueByUser(): Observable<LeagueListbyUser[]> {
    return this.http.get<any>(`${environment.apiUrl}/api/League/GetListLeagueByUser`, { headers: this.headers })
      .pipe(
        map((LeagueListbyUser: LeagueListbyUser[]) => LeagueListbyUser),
        catchError(err => throwError(err))
      )
  }
  public getLeagueInfo(
    leagueId: number
  ): Observable<LeagueDetailResponse> {
    return this.http.get<any>(`${environment.apiUrl}/api/League/GetListLeagueInfo/${leagueId}`, { headers: this.headers });
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


  getMatchEvent(matchId: number): Observable<MatchEvent[]> {
    return this.http.get<any>(`${environment.apiUrl}/api/Event/GetMatchEvent/${matchId}`,).pipe(
      map((res: MatchEvent[]) => res),
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
  getLeagueClubFees(leagueId: number, clubId: number): Observable<LeagueClubFeeResponse> {
    return this.http.get<any>(`${environment.apiUrl}/api/Fee/GetLeagueClubFees/${leagueId}/${clubId}`).pipe(
      map((res: LeagueClubFeeResponse) => res),
      catchError(err => throwError(err))
    )
  }

  getmatch(leagueId: number): Observable<MatchScheduleResponse> {
    let params = new HttpParams();

    params = params.append("leagueId", String(leagueId))

    return this.http.get<any>(`${environment.apiUrl}/api/Match/GetLeagueSchedule`, { params }).pipe(
      map((res: MatchScheduleResponse) => res),
      catchError(err => throwError(err))
    )
  }

  confirmRegistFee(fee:LeagueClubFee ){
    return this.http.put(`${environment.apiUrl}/api/Participation/ConfirmRegistFee`, fee, { headers: this.headers })

  }

  getFeeDetail(leagueFeeId: number): Observable<FeeDetailResponse> {
    
    return this.http.get<any>(`${environment.apiUrl}/api/Fee/GetFeeDetail/${leagueFeeId}` ).pipe(
      map((res: FeeDetailResponse) => res),
      catchError(err => throwError(err))
    )
  }
  editLeagueFee(feeInfo: FeeDetail){
    return this.http.put(`${environment.apiUrl}/api/Fee/UpdateFee`, feeInfo, { headers: this.headers });

  }
}
