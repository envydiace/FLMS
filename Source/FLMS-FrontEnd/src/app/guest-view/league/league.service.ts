import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { LeagueDetail } from './../../models/league-detail.model';
import { LeagueDetailResponse } from './../../models/league-detail-response.model';
import { MatchScheduleResponse } from './../../models/match-schedule-response.model';


@Injectable({
  providedIn: 'root'
})

export class LeagueService {
  private httpOptions = {
    headers: new HttpHeaders({
      'Content-Type': 'application/json',
      // Authorization: 'my-auth-token'
    }),
  };

  constructor(
    private http: HttpClient
  ) { }

  public getLeagueInfo(
    leagueId: number
  ): Observable<LeagueDetailResponse> {
    return this.http.get<any>(`${environment.apiUrl}/api/League/GetListLeagueInfo/${leagueId}`);
  }

  getmatch(leagueId: number): Observable<MatchScheduleResponse>{
    let params = new HttpParams();

    params = params.append("leagueId", String(leagueId) )

    return this.http.get<any>(`${environment.apiUrl}/api/Match/GetLeagueSchedule`, { params }).pipe(
      map((res: MatchScheduleResponse) => res),
      catchError(err => throwError(err))
    )
  } 
}
