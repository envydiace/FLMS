import { Injectable } from '@angular/core';
import { token } from '../../models/token.model';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Router } from '@angular/router';
import { environment } from '../../../environments/environment';
import { LeagueListbyUser, LeagueDetail, GetUpdateLeagueDetail } from '../../models/league-detail.model';
import { map, catchError } from 'rxjs/operators';
import { Observable, throwError } from 'rxjs';
import { LeagueDetailResponse, UpdateLeagueDetailResponse } from 'src/app/models/league-detail-response.model';
import { ClubListByLeagueResponse } from 'src/app/models/club-list-by-league-response.model';
import { MatchEvent } from 'src/app/models/match-event-detail.model';
import { FeeDetailResponse, LeagueClubFeeResponse, LeagueFeeResponse } from 'src/app/models/fee-response.model';
import { MatchScheduleResponse } from 'src/app/models/match-schedule-response.model';
import { FeeDetail, LeagueClubFee } from 'src/app/models/fee-detail.model';
import { LeagueTree, UpdateTreeModel } from './../../models/league-tree.model';
import { LeagueStatisticResponse } from './../../models/league-statistics-response.model';
import { LeagueStatisticTypeKO } from './../../models/league-statistic-type-ko.model';


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

  confirmRegistFee(fee: LeagueClubFee): Observable<any> {
    return this.http.put(`${environment.apiUrl}/api/Participation/ConfirmRegistFee`, fee, { headers: this.headers })

  }

  getFeeDetail(leagueFeeId: number): Observable<FeeDetailResponse> {

    return this.http.get<any>(`${environment.apiUrl}/api/Fee/GetFeeDetail/${leagueFeeId}`).pipe(
      map((res: FeeDetailResponse) => res),
      catchError(err => throwError(err))
    );
  }
  editLeagueFee(feeInfo: any): Observable<any> {
    return this.http.put(`${environment.apiUrl}/api/Fee/UpdateFee`, feeInfo, { headers: this.headers });
  }

  removeJoinedClub(leagueId: number, clubId: number): Observable<any> {
    let params = new HttpParams();

    params = params.append("leagueId", String(leagueId));
    params = params.append("clubId", String(clubId));
    return this.http.delete(`${environment.apiUrl}/api/Participation/RemoveJoinedClub`, { params, headers: this.headers });

  }

  finishMatchConfirm(matchId: number): Observable<any> {
    return this.http.put(`${environment.apiUrl}/api/Match/FinishMatch/${matchId}`, null, { headers: this.headers });
  }

  getLeagueStatistics(leagueId: number): Observable<LeagueStatisticResponse> {
    return this.http.get(`${environment.apiUrl}/api/League/GetLeagueStatistic/${leagueId}`).pipe(map((res: LeagueStatisticResponse) => res),
      catchError(err => throwError(err)));
  }

  getJoinedLeagueByUser(): Observable<LeagueDetail[]> {
    return this.http.get<any>(`${environment.apiUrl}/api/Participation/GetListJoinedLeague`, { headers: this.headers })
      .pipe(
        map((res: LeagueDetail[]) => res),
        catchError(err => throwError(err))
      );
  }

  deleteLeague(leagueId: number): Observable<any> {
    return this.http.delete<any>(`${environment.apiUrl}/api/League/DeleteLeague/${leagueId}`, { headers: this.headers });
  }

  getLeagueTree(leagueId: number): Observable<LeagueTree> {
    return this.http.get(`${environment.apiUrl}/api/Participation/GetLeagueTree/${leagueId}`)
      .pipe(map((res: LeagueTree) => res),
        catchError(err => throwError(err)));
  }

  updateLeagueTree(tree: UpdateTreeModel): Observable<any> {
    return this.http.put(`${environment.apiUrl}/api/Participation/ManageLeagueSettingKO`, tree, { headers: this.headers });
  }

  getLeagueStatisticTypeKO(leagueId: number): Observable<LeagueStatisticTypeKO> {
    return this.http.get(`${environment.apiUrl}/api/League/GetKnockOutStatistic/${leagueId}`).pipe(map((res: LeagueStatisticTypeKO) => res),
      catchError(err => throwError(err)));
  }

  exportLeagueSchedule(leagueId: number): Observable<any> {
    return this.http.get(`${environment.apiUrl}/api/Export/ExporLeagueSchedule/${leagueId}`, { responseType: 'arraybuffer' });
  }

  editFee(leagueId: number, isActual: boolean, listFees: FeeDetail[]): Observable<any> {
    let body = {
      leagueId,
      isActual,
      listFees
    }
    return this.http.post(`${environment.apiUrl}/api/Fee/AddLeagueFee`, body, { headers: this.headers });
  }

  removeLeagueFee(leagueFeeId: number): Observable<any> {
    return this.http.post<any>(`${environment.apiUrl}/api/Fee/DeleteLeagueFee/${leagueFeeId}`, null, { headers: this.headers });
  }

  getUpdateLeagueInfo(leagueId: number): Observable<UpdateLeagueDetailResponse> {
    return this.http.get<any>(`${environment.apiUrl}/api/League/GetLeagueUpdateInfo/${leagueId}`, { headers: this.headers }).pipe(
      map((res: UpdateLeagueDetailResponse) => res),
      catchError(err => throwError(err))
    );
  }
  updateLeague(league: GetUpdateLeagueDetail) {
    return this.http.put(`${environment.apiUrl}/api/League/UpdateLeagueBasicInfo`, league, { headers: this.headers });
  }
  loseJudge(matchId: number, clubId: number): Observable<any> {
    let body = {
      matchId,
      clubId
    }
    return this.http.put<any>(`${environment.apiUrl}/api/Match/LoseJudge`, body, { headers: this.headers });
  }

}
