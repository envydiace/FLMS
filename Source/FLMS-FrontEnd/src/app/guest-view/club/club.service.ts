import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { map, catchError } from 'rxjs/operators';
import { ClubList } from './../../models/club-list.model';

@Injectable({
  providedIn: 'root'
})
export class ClubService {
  private httpOptions = {
    headers: new HttpHeaders({
      'Content-Type': 'application/json',
      // Authorization: 'my-auth-token'
    }),
  };

  constructor(
    private http: HttpClient
  ) { }

  findAll(page: number, size: number): Observable<ClubList> {
    let params = new HttpParams();

    params = params.append('page', String(page));
    params = params.append('pageSize', String(size));

    return this.http.get<any>(`${environment.apiUrl}/api/Club/GetListClubFilter`, {params}).pipe(
      map((clubList: ClubList) => clubList),
      catchError(err => throwError(err))
    )
  }

  public getListClubFilter(
    clubName: string,
    managerName: string,
    page: number,
    size: number
  ): Observable<any> {
    let params = new HttpParams();

    params = params.append('searchClubName', clubName);
    params = params.append('searchManagerName', managerName);
    params = params.append('page', String(page));
    params = params.append('pageSize', String(size));

    return this.http.get<any>(`${environment.apiUrl}/api/Club/GetListClubFilter`, { params });
  }
}
