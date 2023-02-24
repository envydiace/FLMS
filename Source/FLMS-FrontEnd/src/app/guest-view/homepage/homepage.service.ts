import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { ClubList } from '../../models/club-list.model';

@Injectable({
  providedIn: 'root'
})
export class HomepageService {

  constructor(
    private http: HttpClient
  ) { }

  getAll() {
    return this.http.get<ClubList[]>(`${environment.apiUrl}/api/GetListClubFilter?page=1&pageSize=5`);
  }
}
