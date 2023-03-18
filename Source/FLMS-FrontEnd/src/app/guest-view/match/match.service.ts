import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { token } from './../../models/token.model';
import { Router } from '@angular/router';
import { MatchDetailResponse } from '../../models/match-detail-response.model';
import { MatchDetail } from '../../models/match-detail.model';
import {MatchStats} from '../../models/match-statistics-model'
import {MatchStatisticsResponse} from './../../models/match-statistic-response-model'
import { MatchEvent } from 'src/app/models/match-event-detail.model';


@Injectable({
  providedIn: 'root'
})
export class MatchService {

  constructor(
    private http: HttpClient,
    private router: Router
  ) { }

  getMatchInfoById(
    matchId: number
  ): Observable<MatchDetailResponse> {
    return this.http.get<any>(`${environment.apiUrl}/api/Match/GetMatchInfo/${matchId}`)
      .pipe(map((res: MatchDetailResponse) => res),
        catchError(err => throwError(err)))
  }

  getMatchStatsById(
    matchId: number
  ): Observable<MatchStatisticsResponse> {
    return this.http.get<any>(`${environment.apiUrl}/api/MatchStatistic/GetMatchStat/${matchId}`)
    .pipe(map((res: MatchStatisticsResponse) => res),
    catchError(err => throwError(err)))
  }


  getMatchEvent(matchId:number): Observable<MatchEvent[]>{
    return this.http.get<any>(`${environment.apiUrl}/api/Event/GetMatchEvent/${matchId}`, ).pipe(
      map((res: MatchEvent[]) => res),
      catchError(err => throwError(err))
    )
  }
}
